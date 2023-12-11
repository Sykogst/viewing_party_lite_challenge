require 'rails_helper'

RSpec.describe 'Log in page using credentials: email and password', type: :feature do
  before(:each) do
    @user = create(:user, email: 'sam@email.com', password: 'pw123')
    visit "/"
  end

  it 'Allows user click link and go to login page', :vcr do
    expect(page).to have_link('Log In')

    click_link 'User Log In'
    expect(current_path).to eq("/login")
  end

  it 'User can log in with good credentials', :vcr do
    click_link 'User Log In'
    
    fill_in :email, with: 'sam@email.com'
    fill_in :password, with: 'pw123'

    click_on "Log In"

    expect(current_path).to eq("/users/#{@user.id}/discover")
    expect(page).to have_content("Welcome, #{@user.name}!")

    expect(page).to_not have_content("User Log In")
    expect(page).to have_content("Log Out")
  end

  it 'User cannot log in with bad credentials, wrong password', :vcr do
    visit '/login'
    
    fill_in :email, with: 'sam@email.com'
    fill_in :password, with: 'badpassword'

    click_on "Log In"

    expect(current_path).to eq("/login")
    expect(page).to have_content("Sorry, your password is incorrect.")
  end

  it 'User cannot log in with bad credentials, email does not exist', :vcr do
    visit '/login'
    
    fill_in :email, with: 'sammy@email.com'
    fill_in :password, with: 'pw123'

    click_on "Log In"

    expect(current_path).to eq("/login")
    expect(page).to have_content("Sorry, your email was not found.")
  end
end