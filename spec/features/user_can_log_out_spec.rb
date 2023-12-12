require 'rails_helper'

RSpec.describe 'Log in page using credentials: email and password', type: :feature do
  before(:each) do
    @user = create(:user, email: 'sam@email.com', password: 'pw123')
    visit "/"
  end

  it 'User can log out' do
    click_link 'User Log In'
    
    fill_in :email, with: 'sam@email.com'
    fill_in :password, with: 'pw123'

    click_on "Log In"

    expect(page).to_not have_content("User Log In")
    expect(page).to have_content("Log Out")

    click_on "Log Out"

    expect(current_path).to eq("/")
    expect(page).to have_content("User Log In")
    expect(page).to have_content("Logged out successfully")
    expect(page).to_not have_content("Log Out")
  end
end