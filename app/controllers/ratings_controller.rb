class RatingsController < ApplicationController
  before_action :authenticate_user!, only: :create
  before_action :load_product, only: :create

  def create
    rating = current_user.ratings.build rating_params
    if rating.save
      flash[:success] = t "flash.rating_success"
    else
      flash[:danger] = t "flash.danger"
    end
    redirect_to @product
  end

  private

  def rating_params
    params.require(:rating).permit :product_id, :score, :message
  end

  def load_product
    @product = Product.find_by id: params[:rating][:product_id]
    return if @product
    flash[:danger] = t "flash.product_not_found"
    redirect_to root_path
  end
end
