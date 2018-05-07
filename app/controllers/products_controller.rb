class ProductsController < ApplicationController
  before_action :load_hash_categories, only: :index
  def index
    @categories = Category.get_sub_categories Settings.category.category_lv0
    @products = Product.all.page(params[:page]).per(Settings.product.per_page)
  end

  def show; end

  private

  def load_hash_categories
    @hash_categories = Category.all.group_by(&:parent_id)
  end
end
