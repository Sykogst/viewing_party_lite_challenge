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
    
    fill_in :email, with: 'sam@email.com'
    fill_in :password, with: 'pw123'

    click_on "Log In"
    visit "/"

    # USER STORY asks to not have email a link anymore...
    # Further extension, asks to have it back as a link when as an admin, so keeping it for now
    expect(page).to have_content(@user.email)
  end
end