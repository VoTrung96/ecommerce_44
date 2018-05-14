class Product < ApplicationRecord
  belongs_to :category
  has_many :images, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :ratings, dependent: :destroy
  has_many :cart_contains, dependent: :nullify

  delegate :name, to: :category, prefix: :category, allow_nil: true
  accepts_nested_attributes_for :images, allow_destroy: true

  validates :name, presence: true
  validates :summary, presence: true
  validates :price, presence: true, numericality: {greater_than_or_equal_to: 0}
  validates :quantity, presence: true, numericality: {only_integer: true,
    greater_than_or_equal_to: 0}

  scope :get_feature_products, (lambda do
    joins(:cart_contains)
    .where("cart_contains.created_at >= DATE(CURRENT_DATE, '-1 MONTH')")
    .group("id").order("sum(cart_contains.quantity) DESC")
    .limit(Settings.product.limit)
  end)
  scope :get_lastest_products, ->(number){order(created_at: :desc).limit(number)}
  scope :get_related_products, ->(id){where(category_id: id).limit(Settings.product.limit)}
  scope :sort_products, ->(sort){order("#{sort}": :asc)}
  scope :get_products_by_category, ->(ids){where("category_id in (?)", ids)}
end
