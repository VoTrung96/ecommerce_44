class Product < ApplicationRecord
  belongs_to :category
  has_many :images, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :ratings, dependent: :destroy
  has_many :cart_contains, dependent: :restrict_with_exception

  delegate :name, to: :category, prefix: :category, allow_nil: true

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
