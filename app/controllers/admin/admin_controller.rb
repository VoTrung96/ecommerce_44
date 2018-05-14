module Admin
  class AdminController < ApplicationController
    before_action :logged_in_user
    before_action :check_role

    layout "admin/application"
  end
end
