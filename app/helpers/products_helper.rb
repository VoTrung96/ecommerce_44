module ProductsHelper
  def show_cover_image product
    image = Image.get_cover_image(product.id).first
    if image.present? && File.exist?(image.name)
      image_tag(image.name)
    else
      image_tag("shoe/no-image.jpg")
    end
  end

  def show_product_images product
    images = Image.get_product_images product.id
    return if images.blank?
    images = images.limit(4).map do |image|
      if image.present? && File.exist?(image.name)
        image_tag(image.name)
      else
        image_tag("shoe/no-image.jpg")
      end
    end
    safe_join images
  end
end
