class User < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :ratings, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :user_suggestions, dependent: :destroy

  validates :email, presence: true, length: {maximum:
    Settings.validate.email_max_length}, format: {with:
    Settings.validate.EMAIL_REGEX}, uniqueness: {case_sensitive: false}
  has_secure_password
  validates :password, presence: true, length: {minimum:
    Settings.validate.password_min_length}, allow_nil: true
  validates :name, presence: true, length: {maximum:
    Settings.validate.name_max_length}
  validates :phone_number, length: {maximum: Settings.validate.phone_max_length},
    format: {with: Settings.validate.PHONE_REGEX}, allow_blank: true
  validates :address, length: {maximum: Settings.validate.address_max_length},
    allow_blank: true

  before_save :downcase_email

  enum role: %i(subcriber admin)

  def self.digest string
    cost = if ActiveModel::SecurePassword.min_cost
             BCrypt::Engine::MIN_COST
           else
             BCrypt::Engine.cost
           end
    BCrypt::Password.create(string, cost: cost)
  end

  def downcase_email
    self.email = email.downcase
  end
end
