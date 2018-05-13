class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :product

  validates :content, presence: true, length: {maximum: Settings.comments.content_max_length}
  scope :sort_by_created_at, ->{order created_at: :desc}
end
