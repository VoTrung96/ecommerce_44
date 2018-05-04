class Category < ApplicationRecord
  has_many :products, dependent: :destroy

  scope :get_sub_categories, ->(parent){where parent_id: parent}
end
