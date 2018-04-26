module ApplicationHelper
  def full_title page_title
    base_title = I18n.t "base_title"
    page_title.blank? ? base_title : "#{page_title} | #{base_title}"
  end

  def count_quantity
    session[:cart] ||= {}
    sum_quantity = 0
    return sum_quantity if session[:cart].blank?
    sum_quantity = session[:cart].sum do |_key, item|
      item["quantity"]
    end
  end
end
