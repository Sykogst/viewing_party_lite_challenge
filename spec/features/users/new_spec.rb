require 'rails_helper'

RSpec.describe 'new user', type: :feature do
  describe 'When user visits "/register"' do
    before(:each) do
      @user_1 = User.create!(name: 'Sam', email: 'sam_t@email.com')

      visit register_user_path
    end

    it 'They see a Home link that redirects to landing page' do
      expect(page).to have_link('Home')
      click_link "Home"
      expect(current_path).to eq(landing_path)
    end

    it 'They see a form that includes Name, Email, and Create New User button' do
      expect(page).to have_field('Name')
      expect(page).to have_field('Email')
      expect(page).to have_selector(:link_or_button, 'Create New User')    
    end

    it 'They fill in form with information, email (unique), submit, redirects to user show page' do
      fill_in 'Name', with: "Sammy"
      fill_in 'Email', with: "sammy@email.com"
      click_button 'Create New User'

      new_user = User.last
      expect(current_path).to eq(user_path(new_user))
      expect(page).to have_content('Successfully Added New User')
    end

    it 'They fill in form with information, email (non-unique), submit, redirects to user show page' do
      fill_in 'Name', with: "Sammy"
      fill_in 'Email', with: "sam_t@email.com"
      click_button 'Create New User'

      expect(current_path).to eq(register_user_path)
      expect(page).to have_content('Error: Email has already been taken')
    end

    it 'They fill in form with missing information' do
      fill_in 'Name', with: ""
      fill_in 'Email', with: ""
      click_button 'Create New User'

      expect(current_path).to eq(register_user_path)
      expect(page).to have_content("Error: Name can't be blank, Email can't be blank")
    end

    it 'They fill in form with invalid email format (only somethng@something.something)' do # Probably more invalid examples
      fill_in 'Name', with: "Sammy"
      fill_in 'Email', with: "sam sam@email.co.uk"
      click_button 'Create New User'

      expect(current_path).to eq(register_user_path)
      expect(page).to have_content('Error: Email is invalid')

      fill_in 'Name', with: "Sammy"
      fill_in 'Email', with: "sam@email..com"
      click_button 'Create New User'

      expect(current_path).to eq(register_user_path)
      expect(page).to have_content('Error: Email is invalid')

      fill_in 'Name', with: "Sammy"
      fill_in 'Email', with: "sam@emailcom."
      click_button 'Create New User'

      expect(current_path).to eq(register_user_path)
      expect(page).to have_content('Error: Email is invalid')

      fill_in 'Name', with: "Sammy"
      fill_in 'Email', with: "sam@emailcom@"
      click_button 'Create New User'

      expect(current_path).to eq(register_user_path)
      expect(page).to have_content('Error: Email is invalid')
    end

  end

end