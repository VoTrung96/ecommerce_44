class CategoriesController < ApplicationController
  before_action :load_categories, only: :show
  before_action :load_hash_categories, only: :show
  before_action :find_category, only: :show

  def show
    @sort = params[:sort] || Settings.sortby.default
    filter_products
  end

  private

  def load_categories
    @categories = Category.get_parent_categories
  end

  def load_hash_categories
    @hash_categories = Category.all.group_by(&:parent_id)
  end

  def find_category
    @category = Category.find_by id: params[:id]
    redirect_to root_path if @category.blank?
  end

  def filter_products
    @products = if @sort == Settings.sortby.default
                  @category.products.page(params[:page])
                    .per(Settings.product.per_page)
                else
                  @category.products.sort_products(@sort)
                    .page(params[:page])
                    .per(Settings.product.per_page)
                end
  end
end
