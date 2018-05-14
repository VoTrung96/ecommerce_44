class Image < ApplicationRecord
  belongs_to :product
  mount_uploader :name, PictureUploader

  scope :get_cover_image, ->(id){(where product_id: id).limit(1)}
end
