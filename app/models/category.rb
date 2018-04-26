class Category < ApplicationRecord
  has_many :products, dependent: :destroy

  scope :get_parent_categories, ->{where parent_id: Settings.category.category_lv0}
end
