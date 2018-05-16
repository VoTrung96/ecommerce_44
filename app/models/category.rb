class Category < ApplicationRecord
  has_many :products, dependent: :destroy
  has_many :sub_categories, class_name: Category.name, foreign_key: :parent_id,
    dependent: :destroy, inverse_of: false

  validates :name, presence: true, length: {maximum:
    Settings.validate.name_max_length}, uniqueness: {case_sensitive: false}
  scope :get_parent_categories, ->{where parent_id: Settings.category.category_lv0}
  scope :get_categories_expect_branch, ->(ids){where("id not in (?)", ids)}

  def child_categories
    sub_categories.inject(sub_categories) do |categories, sub|
      categories + sub.child_categories
    end
  end

  def branch_categories
    ([self] + child_categories).map(&:id).uniq
  end
end
