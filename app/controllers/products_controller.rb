class ProductsController < ApplicationController
  before_action :load_categories, only: %i(index show)
  before_action :load_hash_categories, only: :index
  before_action :find_product, only: :show

  def index
    @sort = params[:sort] || Settings.sortby.default
    filter_products @sort
  end

  def show
    @related_products = Product.get_related_products @product.category_id
    @images = @product.images
  end

  private

  def load_categories
    @categories = Category.get_parent_categories
  end

  def load_hash_categories
    @hash_categories = Category.all.group_by(&:parent_id)
  end

  def find_product
    @product = Product.find_by id: params[:id]
    redirect_to products_path if @product.blank?
  end

  def filter_products sort
    @products = if sort == Settings.sortby.default
                  Product.all.page(params[:page])
                    .per(Settings.product.per_page)
                else
                  Product.sort_products(@sort).page(params[:page])
                    .per(Settings.product.per_page)
                end
  end
end
