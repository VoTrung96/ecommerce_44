class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  before_action :set_cart

  private

  def set_cart
    @cart = session[:cart] ||= {}
  end
end
