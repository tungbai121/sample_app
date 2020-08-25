class User < ApplicationRecord
  VALID_EMAIL_REGEX = Settings.user.email.regex
  USER_PARAMS = %i(name email password password_confirmation).freeze

  validates :email, presence: true,
    length: {maximum: Settings.user.email.length},
    format: {with: VALID_EMAIL_REGEX},
    uniqueness: true
  validates :name, presence: true,
    length: {maximum: Settings.user.name.length}
  validates :password, presence: true,
    length: {minimum: Settings.user.password.length}

  before_save :downcase_email

  has_secure_password

  private

  def downcase_email
    email.downcase!
  end
end
