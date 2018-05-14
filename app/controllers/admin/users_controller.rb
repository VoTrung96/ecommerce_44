module Admin
  class UsersController < AdminController
    rescue_from ActiveRecord::RecordNotFound do |exception|
      respond_to do |format|
        format.html{redirect_to admin_users_path, alert: exception.message}
      end
    end

    def index
      @users = User.all.page(params[:page]).per(Settings.users.per_page)
    end

    def destroy
      if !@user.admin? && @user.destroy
        flash[:success] = t "flash.delete_success"
      else
        flash[:danger] = t "flash.danger"
      end
      redirect_to admin_users_path
    end
  end
end
