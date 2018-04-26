class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  include ApplicationHelper

  def set_cart
    @cart = session[:cart] ||= {}
  end
end
