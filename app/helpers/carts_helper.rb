module CartsHelper
  def count_quantity
    session[:cart] ||= {}
    return 0 if session[:cart].blank?
    sum_quantity = session[:cart].sum do |_key, item|
      item["quantity"]
    end
  end

  def calculate_grand_total
    session[:cart] ||= {}
    return 0 if session[:cart].blank?
    grand_total = session[:cart].sum do |_key, item|
      cal_total item["quantity"], item["price"]
    end
  end

  def check_cart
    return if @cart.present?
    flash[:danger] = I18n.t "flash.cart_empty"
    redirect_to products_path
  end

  def load_items
    @items = []
    @cart.each_value do |item|
      @items << CartContain.new(item)
    end
  end

  def set_cart
    @cart = session[:cart] ||= {}
  end

  def cal_total quantity, price
    quantity * price
  end
end
