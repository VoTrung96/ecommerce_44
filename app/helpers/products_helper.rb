module ProductsHelper
  def show_cover_image product
    image = load_images(product).first
    show_image image
  end

  def show_product_images product
    images = load_images product
    return if images.blank?
    images = images.limit(4).map do |image|
      show_image image
    end
    safe_join images
  end

  private

  def check_image? image
    image.present? && File.exist?(image.name)
  end

  def load_images product
    Image.get_product_images product.id
  end

  def show_image image
    name = check_image?(image) ? image.name : "shoe/no-image.jpg"
    image_tag name
  end
end
