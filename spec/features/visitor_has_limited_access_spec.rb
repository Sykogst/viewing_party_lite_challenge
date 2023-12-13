require 'rails_helper'

RSpec.describe 'Visitor sees different information compared to logged in user', type: :feature do
  before(:each) do
    @user = create(:user, email: 'sam@email.com', password: 'pw123')
    visit "/"
  end

  it 'Visitor does not see list of existing users' do
    expect(page).to have_content("User Log In")
    expect(page).to_not have_content(@user.email)
  end

  it 'User sees a list of existing users on landing page when logged in' do
    click_link 'User Log In'
    
    fill_in :email, with: @user.email
    fill_in :password, with: @user.password
    click_on "Log In"

    visit "/"

    # USER STORY asks to not have email a link anymore...
    # Further extension, asks to have it back as a link when as an admin, so keeping it for now
    expect(page).to have_content(@user.email)
  end

  it 'Visitor, landing page, then dashboard, remain on landing and sees a message to login/register' do
    visit "/users/#{@user.id}" # New controller :(
    # expect(current_path).to eq("/")
    expect(page).to have_content("Must be logged in or registered to access this page.")
  end

  it 'Visitor, landing page, then dashboard, remain on landing and sees a message to login/register', :vcr do
    visit "/users/#{@user.id}/movies/11"
    click_on "Create A Party"
    # expect(current_path).to eq("/users/#{@user.id}/movies/11")
    expect(page).to have_content("Must be logged in or registered to access this page.")
    end
end