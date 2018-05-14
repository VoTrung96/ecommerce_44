module ApplicationHelper
  def full_title page_title
    base_title = I18n.t "base_title"
    page_title.blank? ? base_title : "#{page_title} | #{base_title}"
  end

  def create_index params_page, index, per_page
    params_page = 1 if params_page.blank?
    (params_page.to_i - 1) * per_page.to_i + index.to_i + 1
  end

  def store_location!
    store_location_for(:user, request.fullpath)
  end
end
