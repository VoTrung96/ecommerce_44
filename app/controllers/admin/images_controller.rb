module Admin
  class ImagesController < AdminController
    before_action :find_image, only: :destroy
    before_action :find_product, only: :destroy

    def destroy
      respond_to do |format|
        if @image.destroy
          format.html{redirect_to @product}
          format.js
        else
          format.js{render t("alert.wrong")}
        end
      end
    end

    private

    def find_image
      @image = Image.find_by id: params[:id]
      return if @image
      render js: t("alert.image_not_found")
    end

    def find_product
      @product = Product.find_by id: @image.product_id
      return if @product
      render js: t("alert.product_not_found")
    end
  end
end
