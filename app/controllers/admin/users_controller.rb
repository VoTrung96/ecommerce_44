module Admin
  class UsersController < AdminController
    load_and_authorize_resource
    rescue_from ActiveRecord::RecordNotFound do |exception|
      respond_to do |format|
        format.html{redirect_to admin_users_path, alert: exception.message}
      end
    end

    def index
      params[:limit] ||= Settings.show_limit.show_5
      @search = User.ransack params[:q]
      @users = @search.result.page(params[:page]).per params[:limit]
      respond_to do |format|
        format.html
        format.js
      end
    end

    def destroy
      if @user.destroy
        flash[:success] = t "flash.delete_success"
      else
        flash[:danger] = t "flash.danger"
      end
      redirect_to admin_users_path
    end
  end
end
