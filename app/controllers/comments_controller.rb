class CommentsController < ApplicationController
  before_action :check_login!, only: :create
  before_action :find_product, only: :create

  def create
    @comment = current_user.comments.build comment_params
    respond_to do |format|
      if @comment.save
        format.html{redirect_to @product}
        format.js
      else
        format.js{render t("alert.wrong")}
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit :product_id, :content
  end

  def find_product
    @product = Product.find_by id: params[:comment][:product_id]
    return if @product
    render js: t("alert.product_not_found")
  end

  def check_login!
    return if current_user.present?
    flash[:danger] = t "flash.login_danger"
    render js: "window.location = '#{new_user_session_path}'"
  end
end
