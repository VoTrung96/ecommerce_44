class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :product
  delegate :name, to: :user, prefix: :user, allow_nil: true
  delegate :name, to: :product, prefix: :product, allow_nil: true
  validates :content, presence: true, length: {maximum: Settings.comments.content_max_length}
  scope :sort_by_created_at, ->{order created_at: :desc}
  scope :get_commnets_by_id, ->(ids){where("id in (?)", ids)}
end
