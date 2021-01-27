class Planner < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  before_save { self.email = email.downcase }
  validates :name, presence: true, length: { maximum: 40 }
  validates :email, { presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }, length: { maximum: 255 } }
  validates :password, presence: true, length: { minimum: 8 }

  has_secure_password
end
