class Planner < ApplicationRecord
  has_many :planner_skills
  has_many :skills, through: :planner_skills

  before_save { self.email = email.downcase }

  validates :name, presence: true, length: { maximum: 40 }
  validates :email, { presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: { case_sensitive: false }, length: { maximum: 255 } }
  validates :password, presence: true, length: { minimum: 8 }

  has_secure_password
end

