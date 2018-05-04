class Image < ApplicationRecord
  belongs_to :product

  scope :get_cover_image, ->(id){(where product_id: id).limit(1)}
  scope :get_product_images, ->(id){where product_id: id}
end
