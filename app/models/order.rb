class Order < ApplicationRecord
  belongs_to :user
  has_many :cart_contains, dependent: :destroy

  enum status: %i(waiting accept cancle)
end
