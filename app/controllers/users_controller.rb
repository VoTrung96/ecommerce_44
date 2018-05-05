class UsersController < ApplicationController
  before_action :load_categories, only: :new

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def load_categories
    @categories = Category.get_sub_categories Settings.category.category_lv0
  end

  def user_params
    params.require(:user).permit :name, :email, :phone_number, :address,
      :password, :password_confirmation
  end
end
