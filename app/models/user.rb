class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable, :confirmable
  has_many :comments, dependent: :destroy
  has_many :ratings, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :user_suggestions, dependent: :destroy

  validates :name, presence: true, length: {maximum:
    Settings.validate.name_max_length}
  validates :phone_number, length: {maximum: Settings.validate.phone_max_length},
    format: {with: Settings.validate.PHONE_REGEX}, allow_blank: true
  validates :address, length: {maximum: Settings.validate.address_max_length},
    allow_blank: true

  before_save :downcase_email

  enum role: %i(subcriber admin)

  private

  def downcase_email
    self.email = email.downcase
  end
end
