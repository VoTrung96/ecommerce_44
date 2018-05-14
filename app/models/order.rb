class Order < ApplicationRecord
  belongs_to :user
  has_many :cart_contains, dependent: :destroy
  delegate :email, to: :user, prefix: :user, allow_nil: true
  delegate :name, to: :user, prefix: :user, allow_nil: true

  enum status: %i(pendding accept reject)

  validates :phone_number, presence: true, length: {maximum: Settings.validate.phone_max_length},
    format: {with: Settings.validate.PHONE_REGEX}
  validates :delivery_address, presence: true, length: {maximum: Settings.validate.address_max_length}

  scope :sort_by_status, ->{order :status}
end
