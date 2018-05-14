module ProductsHelper
  def show_cover_image product
    image = product.images.first
    image_tag get_image_name(image)
  end

  def show_product_images product
    images = product.images
    return if images.blank?
    images = images.limit(4).map do |image|
      image_tag get_image_name(image)
    end
    safe_join images
  end

  def get_image_name image
    check_image?(image) ? image.name.url : "shoe/no-image.jpg"
  end

  def show_cart_preview item
    return image_tag "shoe/no-image.jpg", size: "100x100" if item.product.blank?
    image_tag get_image_name(item.product.images.first), size: "100x100"
  end

  def show_product_preview product
    image_tag get_image_name(product.images.first), size: "100x100"
  end

  private

  def check_image? image
    image.present? && image.name?
  end
end
