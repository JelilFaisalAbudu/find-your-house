class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.freeze
  before_save { self.email = email.downcase }

  has_secure_password

  validates :name, presence: true
  validates :email,
            presence: true,
            format: { with: VALID_EMAIL_REGEX },
            uniqueness: true
  validates :password_digest, presence: true

  has_many :favorites, dependent: :destroy
  has_many :favorite_houses, through: :favorites, source: :house
end
