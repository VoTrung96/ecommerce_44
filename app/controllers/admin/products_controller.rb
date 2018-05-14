module Admin
  class ProductsController < AdminController
    rescue_from ActiveRecord::RecordNotFound do |exception|
      respond_to do |format|
        format.html{redirect_to admin_products_path, alert: exception.message}
      end
    end
    before_action :load_categories, only: %i(new edit)

    def index
      params[:limit] ||= Settings.show_limit.show_5
      @search = Product.joins(:category).ransack params[:q]
      @products = @search.result.page(params[:page]).per params[:limit]
      respond_to do |format|
        format.html
        format.js
      end
    end

    def new
      build_image
    end

    def create
      if @product.save
        flash[:success] = t "flash.add_success"
        redirect_to admin_products_path
      else
        build_image
        load_categories
        flash.now[:danger] = t "flash.danger"
        render :new
      end
    end

    def edit
      return if @product.images.present?
      build_image
    end

    def update
      if @product.update product_params_update
        flash[:success] = t "flash.update_success"
        redirect_to admin_products_path
      else
        load_categories
        flash.now[:danger] = t "flash.danger"
        render :edit
      end
    end

    def destroy
      if @product.destroy
        flash[:success] = t "flash.delete_success"
      else
        flash[:danger] = t "flash.danger"
      end
      redirect_to admin_products_path
    end

    private

    def product_params
      params.require(:product).permit :category_id, :name, :summary, :price,
        :quantity, images_attributes: %i(product_id name)
    end

    def product_params_update
      params.require(:product).permit :category_id, :name, :summary, :price,
        :quantity, images_attributes: %i(id name _destroy)
    end

    def load_categories
      @categories = Category.all
    end

    def build_image
      @product.images.build
    end
  end
end
