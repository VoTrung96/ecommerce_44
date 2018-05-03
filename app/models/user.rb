class User < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :ratings, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :user_suggestions, dependent: :destroy

  enum role: %i(subcriber admin)
end
