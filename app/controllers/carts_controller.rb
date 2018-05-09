class CartsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :load_product, only: :add

  def add
    if check_quantity?
      cart_contain = CartContain.new product_id: @product.id,
        quantity: params[:quantity].to_i, price: @product.price
      add_to_cart cart_contain
      session[:cart] = @cart
      render json: {err: 0, quantity: count_quantity}
    else
      render json: {err: 1}
    end
  end

  def change; end

  private

  def load_product
    @product = Product.find_by id: params[:product_id]
  end

  def count_quantity
    session[:cart] ||= {}
    sum_quantity = 0
    return sum_quantity if session[:cart].blank?
    sum_quantity = session[:cart].sum do |_key, item|
      item["quantity"]
    end
  end

  def add_to_cart item
    if @cart[params[:product_id]]
      @cart[params[:product_id]]["quantity"] += params[:quantity].to_i
    else
      @cart[@product.id] = item
    end
  end

  def check_quantity?
    quantity = params[:quantity].to_i
    quantity += @cart[params[:product_id]]["quantity"] if is_exists_item_in_cart?
    return false if quantity > @product.quantity
    true
  end

  def is_exists_item_in_cart?
    @cart.present? && @cart[params[:product_id]].present?
  end
end
