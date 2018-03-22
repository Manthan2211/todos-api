class User < ApplicationRecord
  
  has_many :todos, foreign_key: :created_by

  validates :name, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email,presence: true,
                  length: { maximum: 255 },
                  format: { with: VALID_EMAIL_REGEX },
                  uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, length: { minimum: 6 },presence: :true
  validates :password_digest, presence: :true

  
end
  