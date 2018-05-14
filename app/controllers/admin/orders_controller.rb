module Admin
  class OrdersController < AdminController
    load_and_authorize_resource
    rescue_from ActiveRecord::RecordNotFound do |exception|
      respond_to do |format|
        format.html{redirect_to admin_orders_path, alert: exception.message}
      end
    end

    def index
      params[:limit] ||= Settings.show_limit.show_5
      @search = Order.joins(:user).ransack params[:q]
      @orders = @search.result.page(params[:page]).per(Settings.order.per_page)
      respond_to do |format|
        format.html
        format.js
      end
    end

    def show; end

    def update
      if @order.update status: @status
        if @order.reject?
          @order.cart_contains.each(&:return_quantity)
          flash[:success] = t "flash.reject_success"
        else
          flash[:success] = t "flash.accept_success"
        end
      else
        flash[:danger] = t "flash.danger"
      end
      redirect_to admin_orders_path
    end

    def destroy
      if @order.destroy
        flash[:success] = t "flash.delete_success"
      else
        flash[:danger] = t "flash.danger"
      end
      redirect_to admin_orders_path
    end
  end
end
