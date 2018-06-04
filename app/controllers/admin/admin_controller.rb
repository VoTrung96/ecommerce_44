module Admin
  class AdminController < ApplicationController
    before_action :authenticate_user!
    before_action :ensure_admin!

    layout "admin/application"

    private

    def ensure_admin!
      return if current_user.admin?
      flash[:danger] = t "flash.not_permitted"
      redirect_to root_path
    end
  end
end
