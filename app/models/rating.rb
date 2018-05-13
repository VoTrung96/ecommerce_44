class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :product

  validates :score, presence: true
  validate  :score_range
  validates :message, presence: true, length: {maximum: Settings.rating.message_max_length}

  scope :sort_by_created_at, ->{order created_at: :desc}

  def score_range
    return unless score < Settings.rating.score_min || score > Settings.rating.score_max
    errors.add :score, I18n.t("flash.out_of_range")
  end
end
