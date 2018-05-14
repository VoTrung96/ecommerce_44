module Admin
  class ProductsController < AdminController
    before_action :load_categories, only: %i(new edit)
    before_action :find_product, only: %i(edit update destroy)

    def index
      @products = Product.all.page(params[:page]).per(Settings.product.per_page_admin)
    end

    def new
      @product = Product.new
    end

    def create
      @product = Product.new product_params
      if @product.save
        save_product_images
        flash[:success] = t "flash.add_success"
        redirect_to admin_products_path
      else
        load_categories
        flash.now[:danger] = t "flash.danger"
        render :new
      end
    end

    def edit; end

    def update
      if @product.update product_params
        update_product_images
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
        :quantity
    end

    def find_product
      @product = Product.find_by id: params[:id]
      return if @product.present?
      flash[:danger] = t "flash.product_not_found"
      redirect_to admin_products_path
    end

    def load_categories
      @categories = Category.all
    end

    def save_product_images
      params[:images]["name"].each do |image|
        @product.images.create!(name: image)
      end
    end

    def update_product_images
      params[:images].each do |_key, image|
        @product.images.create!(name: image) if image.present?
      end
    end
  end
end
