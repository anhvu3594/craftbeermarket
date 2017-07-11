class User < ApplicationRecord

  has_many :tokens

  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence:   true, length: { maximum: 255 },
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }

  before_save { self.email = email.downcase }
  # def update_reset_password_token!
  #   update_column(:reset_password_token, SecureRandom.hex)
  # end
  #
  # def update_confirmed_token!
  #   update_column(:confirmed_token, SecureRandom.hex)
  # end

end
