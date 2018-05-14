module Admin
  class OrdersController < AdminController
    before_action :load_order, only: %i(show update destroy)
    before_action :check_param, only: :update
    before_action :check_order_delete, only: :destroy

    def index
      @orders = Order.sort_by_status.page(params[:page]).per(Settings.order.per_page)
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

    private

    def load_order
      @order = Order.find_by id: params[:id]
      return if @order.present?
      flash[:danger] = t "flash.order_not_found"
      redirect_to admin_orders_path
    end

    def check_status
      return if @order.pendding?
      flash[:danger] = t "flash.cant_update_status"
      redirect_to admin_orders_path
    end

    def check_param
      @status = params[:status].to_i
      return if [Settings.status.accept_status, Settings.status.reject_status].include? @status
      flash[:danger] = t "flash.status_not_available"
      redirect_to admin_orders_path
    end

    def check_order_delete
      return if @order.reject?
      flash[:danger] = t "flash.cant_delete_order"
      redirect_to admin_orders_path
    end
  end
end
