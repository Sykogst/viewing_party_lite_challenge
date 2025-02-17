require 'rails_helper'

RSpec.describe UserParty, type: :model do
  describe 'validations and relationships' do
    it { should validate_presence_of :user }
    it { should validate_presence_of :party }
    
    it { should belong_to :user }
    it { should belong_to :party }
  end
end