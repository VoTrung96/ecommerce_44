class StaticPagesController < ApplicationController
  def home
    @categories = Category.get_parent_categories
    @features_products = Product.get_feature_products
    @lastest_products = Product.get_lastest_products Settings.product.limit
  end
end
