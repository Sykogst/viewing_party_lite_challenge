require 'rails_helper'

RSpec.describe Party, type: :model do
  before(:each) do
    @user_1 = User.create!(name: 'Sam', email: 'sam_t@email.com', password: 'pw123', password_confirmation: 'pw123')
    @user_2 = User.create!(name: 'Tommy', email: 'Tommy_t@email.com', password: 'pw123', password_confirmation: 'pw123')
    @party = Party.create(movie_id: 238, movie_title: "The Godfather", date: "2023-12-01", start_time: "07:25", image_path: "image.godfather.path", duration: 175)
    UserParty.create!(user_id: @user_1.id, party_id: @party.id, host: true)
    UserParty.create!(user_id: @user_2.id, party_id: @party.id, host: false)
  end
  
  describe 'validations and relationships' do
    it { should validate_presence_of :movie_id }
    it { should validate_numericality_of :movie_id }

    it { should have_many :user_parties }
    it { should have_many(:users).through(:user_parties) }
  end

  describe "instance methods" do
    it "#date_and_time" do 
      expected_result = "December 1, 2023 07:25"

      expect(@party.date_and_time).to eq(expected_result)
    end

    it "returns 'Hosting' or 'Invited' if host is true/false" do
      expect(@party.host?(@user_1)).to eq("Hosting")
      expect(@party.host?(@user_2)).to eq("Invited")
    end

    it "returns the name of users attending a specific party who are not the host" do
      expect(@party.attendees).to be_an(Array)
    end
  end
end