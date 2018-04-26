class Product < ApplicationRecord
  belongs_to :category
  has_many :images, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :ratings, dependent: :destroy
  has_many :cart_contains, dependent: :restrict
end
