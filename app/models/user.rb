class User < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates_presence_of :password
  validates_presence_of :password_confirmation
  validates_presence_of :password_digest

  has_many :user_parties
  has_many :parties, through: :user_parties

  has_secure_password
end
