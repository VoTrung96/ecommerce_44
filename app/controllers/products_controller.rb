class ProductsController < ApplicationController
  before_action :load_categories, only: %i(index show)
  before_action :load_categories_group_by_parent, only: :index
  before_action :find_product, only: :show

  def index
    @sort = params[:sort] || Settings.sortby.default
    filter_products
  end

  def show
    @related_products = Product.get_related_products @product.category_id
    @images = @product.images
    @ratings = @product.ratings.sort_by_created_at
    @rating = Rating.find_by(product_id: @product.id, user_id: current_user.id) if current_user.present?
    @avg_score = calculate_avg_score @ratings
    @comments = @product.comments.sort_by_created_at
    store_location
  end

  private

  def load_categories
    @categories = Category.get_parent_categories
  end

  def load_categories_group_by_parent
    @hash_categories = Category.all.group_by(&:parent_id)
  end

  def find_product
    @product = Product.find_by id: params[:id]
    redirect_to products_path if @product.blank?
  end

  def filter_products
    @products = if @sort == Settings.sortby.default
                  Product.all.page(params[:page])
                    .per(Settings.product.per_page)
                else
                  Product.sort_products(@sort).page(params[:page])
                    .per(Settings.product.per_page)
                end
  end

  def calculate_avg_score ratings
    return 0 if ratings.blank?
    ratings.sum(&:score) / ratings.size
  end
end
