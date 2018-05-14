module Admin
  class CommentsController < AdminController
    rescue_from ActiveRecord::RecordNotFound do |exception|
      respond_to do |format|
        format.html{redirect_to admin_comments_path, alert: exception.message}
      end
    end
    before_action :load_comments, only: %i(index delete)

    def index
      respond_to do |format|
        format.html
        format.js
      end
    end

    def delete
      Comment.get_commnets_by_id(params[:ids]).destroy_all
      respond_to do |format|
        format.html{render layout: false}
      end
    end

    def destroy
      if @comment.destroy
        flash[:success] = t "flash.delete_success"
      else
        flash[:danger] = t "flash.danger"
      end
      redirect_to admin_comments_path
    end

    private

    def load_comments
      @comments = Comment.all.sort_by_created_at.page(params[:page])
        .per(Settings.comments.per_page_admin)
    end
  end
end
