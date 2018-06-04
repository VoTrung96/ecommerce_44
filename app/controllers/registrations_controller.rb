class RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_in_params, only: :create
  before_action :configure_account_update_params, only: :update

  protected

  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_up, keys: %i(name address phone_number))
  end

  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: %i(name address phone_number))
  end

  def after_update_path_for resource
    edit_user_registration_path(resource)
  end
end
