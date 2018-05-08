class User < ApplicationRecord
  attr_accessor :remember_token

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

  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update remember_digest: User.digest(remember_token)
  end

  def authenticated? token
    BCrypt::Password.new(remember_digest).is_password? token
  end

  def forget
    update remember_digest: nil
  end

  private

  def downcase_email
    self.email = email.downcase
  end
end
