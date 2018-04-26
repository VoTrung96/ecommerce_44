module ApplicationHelper
  def full_title page_title
    base_title = I18n.t "base_title"
    page_title.blank? ? base_title : "#{page_title} | #{base_title}"
  end

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
      item["quantity"] * item["price"]
    end
  end
end
