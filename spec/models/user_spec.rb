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

  end
end