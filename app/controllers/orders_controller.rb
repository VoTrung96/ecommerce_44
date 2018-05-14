class OrdersController < ApplicationController
  before_action :logged_in_user, expect: %(edit destroy)
  before_action :load_categories, only: %i(index new show)
  before_action :set_cart, expect: %(edit update)
  before_action :check_cart, only: %i(new create)
  before_action :load_items, only: %i(new create)
  before_action :create_order, only: :create
  before_action :find_order, only: %i(show update)
  before_action :correct_user, only: %i(show update)

  def index
    @orders = current_user.orders.page(params[:page]).per(Settings.order.per_page)
    return if @orders.present?
    flash[:danger] = t "flash.orders_empty"
    redirect_to products_path
  end

  def show; end

  def new
    @order = Order.new
  end

  def create
    if @order.save
      flash[:success] = t "flash.order_success"
      session[:cart] = {}
      redirect_to orders_path
    else
      flash[:danger] = t "flash.danger"
      render :new
    end
  end

  def update
    if @order.update status: Settings.status.reject_status
      @order.cart_contains.each(&:return_quantity) if @order.reject?
      flash[:success] = t "flash.reject_success"
    else
      flash[:success] = t "flash.danger"
    end
    redirect_to orders_path
  end

  private

  def order_params
    params.require(:order).permit :phone_number, :delivery_address
  end

  def find_order
    @order = Order.find_by id: params[:id]
    redirect_to root_url if @order.blank?
  end

  def create_order
    @order = current_user.orders.new order_params
    @order.grand_total = 0
    @cart.each_value do |item|
      @order.cart_contains << @order.cart_contains.new(item)
    end
  end

  def load_categories
    @categories = Category.get_parent_categories
  end

  def correct_user
    redirect_to root_url unless current_user? @order.user
  end
end
