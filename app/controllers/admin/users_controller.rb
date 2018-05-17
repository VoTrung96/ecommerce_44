module Admin
  class UsersController < AdminController
    before_action :find_user, only: :destroy

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

    private

    def find_user
      @user = User.find_by id: params[:id]
      return if @user.present?
      flash[:danger] = t "flash.user_not_found"
      redirect_to admin_users_path
    end
  end
end
