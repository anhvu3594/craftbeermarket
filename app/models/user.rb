class User < ApplicationRecord
  has_many :tokens
  has_one :passport, dependent: :destroy
  has_and_belongs_to_many :chatrooms
  has_many :messages
  has_many :friendships
  has_many :friends, through: :friendships, class_name: 'User'

  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence:   true,
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  # edit password to password_digest for test in admin_active
  validates :password, presence: true, length: { minimum: 6 }

  before_save { self.email = email.downcase }
  after_create { create_passport! }

  def admin?
    role == 1
  end

end
