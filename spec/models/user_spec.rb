require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations and relationships' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :email }
    it { should validate_uniqueness_of :email }
    it { should allow_value('something@something.something').for(:email) }
    it { should_not allow_value('something somthing@something.something').for(:email) }
    it { should_not allow_value('something.something@').for(:email) }
    it { should_not allow_value('something').for(:email) }

    it { should have_many :user_parties }
    it { should have_many(:parties).through(:user_parties) }
  end

  describe 'Authentication additions' do
    it { should validate_presence_of :password }
    it { should validate_presence_of(:password_digest) }
    it { should have_secure_password }

    it 'create user with valid information' do
      user = User.create(name: 'Meg', email: 'meg@test.com', password: 'password123', password_confirmation: 'password123')
      expect(user).to_not have_attribute(:password)
      expect(user.password_digest).to_not eq('password123')
    end
  end
end