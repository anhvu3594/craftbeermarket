class User < ApplicationRecord

  has_many :tokens
  has_one :passport, dependent: :destroy

  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence:   true, length: { maximum: 255 },
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  # edit password to password_digest for test in admin_active
  validates :password_digest, presence: true, length: { minimum: 6 }

  before_save { self.email = email.downcase }
  after_create { self.create_passport! }
  def is_admin?
    role == 1 ? true : false
  end

end
