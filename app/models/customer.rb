class Customer < ApplicationRecord
  before_save { self.email = email.downcase }

  validates :name, presence: true, length: { maximum: 40 }
  validate :no_4_bytes
  validates :email, { presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: { case_sensitive: false }, length: { maximum: 255 } }
  validates :password, presence: true, length: { minimum: 8 }

  has_secure_password

  def no_4_bytes
    return unless name.present?

    chars = name.each_char.select { |c| c.bytes.count >= 4 }
    errors.add(:name, "に絵文字(#{chars.join('')})は使用できません。") unless chars.empty?
  end
end

