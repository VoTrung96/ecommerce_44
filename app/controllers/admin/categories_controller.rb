module Admin
  class CategoriesController < AdminController
    rescue_from ActiveRecord::RecordNotFound do |exception|
      respond_to do |format|
        format.html{redirect_to admin_orders_path, alert: exception.message}
      end
    end

    before_action :load_categories_group_by_parent, only: %i(index edit destroy)
    before_action :load_categories, only: :new
    before_action :load_categories_for_update, only: :edit

    def index; end

    def new; end

    def create
      if @category.save
        flash[:success] = t "flash.add_success"
        redirect_to admin_categories_path
      else
        flash.now[:danger] = t "flash.danger"
        load_categories
        render :new
      end
    end

    def edit; end

    def update
      if @category.update category_params
        flash[:success] = t "flash.update_sucess"
        redirect_to admin_categories_path
      else
        flash.now[:danger] = t "flash.danger"
        load_categories_for_update
        render :edit
      end
    end

    def destroy
      if @category.destroy
        flash[:success] = t "flash.delete_success"
      else
        flash[:danger] = t "flash.danger"
      end
      redirect_to admin_categories_path
    end

    private

    def load_categories_group_by_parent
      @hash_categories = Category.all.group_by(&:parent_id)
    end

    def load_categories
      @categories = Category.all
    end

    def category_params
      params.require(:category).permit :name, :parent_id
    end

    def load_categories_for_update
      @categories = Category.get_categories_expect_branch @category.branch_categories
    end
  end
end
