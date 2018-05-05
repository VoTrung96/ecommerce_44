class UsersController < ApplicationController
  before_action :load_categories, only: %i(new edit)
  before_action :find_user, only: %i(edit update)

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = t "flash.wellcome"
      redirect_to edit_user_path @user
    else
      flash[:danger] = t "flash.danger"
      render :new
    end
  end

  def edit; end

  def update
    if @user.update user_params
      flash[:success] = t "flash.update_profile_success"
      redirect_to edit_user_path @user
    else
      flash[:danger] = t "flash.danger"
      render :edit
    end
  end

  private

  def find_user
    @user = User.find_by id: params[:id]
    return if @user.present?
    flash[:danger] = t "flash.user_invalid"
    redirect_to root_path
  end

  def load_categories
    @categories = Category.get_parent_categories
  end

  def user_params
    params.require(:user).permit :name, :email, :phone_number, :address,
      :password, :password_confirmation
  end
end
