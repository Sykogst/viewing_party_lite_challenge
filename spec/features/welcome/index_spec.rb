require 'rails_helper'

RSpec.describe 'landing page, welcome index', type: :feature do
  describe 'When a user visits the root path "/"' do
    before(:each) do
      @user_1 = User.create!(name: 'Sam', email: 'sam_t@email.com', password: 'pw123', password_confirmation: 'pw123')
      @user_2 = User.create!(name: 'Tommy', email: 'tommy123@email.com', password: 'pw123', password_confirmation: 'pw123')

      visit login_path
      fill_in :email, with: @user_1.email
      fill_in :password, with: @user_1.password
      click_on "Log In"

      visit landing_path
    end

    it 'They see title of application, and link back to home page' do
      expect(page).to have_content('Viewing Party')
      expect(page).to have_link('Home')
    end

    it 'They see button to create a New User' do
      expect(page).to have_selector(:link_or_button, 'Create New User')
    end

    it 'They see list of existing Users, which links to users dashboard, each dashboard has link back to landing page' do
      expect(page).to have_content('Existing Users')
      expect(page).to have_link('sam_t@email.com')
      expect(page).to have_link('tommy123@email.com')

      click_link 'sam_t@email.com'
      expect(current_path).to eq(user_path(@user_1))
      expect(page).to have_link('Home')

      click_link "Home"
      expect(current_path).to eq(landing_path)

      click_link 'tommy123@email.com'
      expect(current_path).to eq(user_path(@user_2))
      expect(page).to have_link('Home')
    end
  end
end
