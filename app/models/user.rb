class User < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates_presence_of :password

  has_many :user_parties
  has_many :parties, through: :user_parties

  has_secure_password
end
