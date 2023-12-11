require 'rails_helper'

RSpec.describe 'new user', type: :feature do
  describe 'When user visits "/register"' do
    before(:each) do
      @user_1 = User.create!(name: 'Sam', email: 'sam_t@email.com', password: 'pw123', password_confirmation: 'pw123')

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

    # Now includes password and password_confirmation
    it 'They fill in form with information, email (unique), submit, password, password_confirmation, redirects to user show page, HAPPY path' do
      fill_in 'Name', with: "Sammy"
      fill_in 'Email', with: "sammy@email.com"
      fill_in 'Password', with: "password123"
      fill_in 'Password Confirmation', with: "password123"
      click_button 'Create New User'

      new_user = User.last
      expect(current_path).to eq(user_path(new_user))
      expect(page).to have_content('Successfully Added New User')
    end

    # Now includes password and password_confirmation SAD PATH 1
    it 'They fill in form with information, email (unique), submit, MISSING: password, password_confirmation, redirects to user register page, SAD path' do
      fill_in 'Name', with: "Sammy"
      fill_in 'Email', with: "sammy@email.com"
      fill_in 'Password', with: ""
      fill_in 'Password Confirmation', with: ""
      click_button 'Create New User'

      expect(current_path).to eq(register_user_path)
      expect(page).to have_content("Error: Password can't be blank, Password confirmation can't be blank")
    end

    # Now includes password and password_confirmation SAD PATH 2
    it 'They fill in form with information, email (unique), submit, Not matching: password, password_confirmation, redirects to user register page, SAD path' do
      fill_in 'Name', with: "Sammy"
      fill_in 'Email', with: "sammy@email.com"
      fill_in 'Password', with: "pw123"
      fill_in 'Password Confirmation', with: "password123"
      click_button 'Create New User'

      expect(current_path).to eq(register_user_path)
      expect(page).to have_content("Error: Password confirmation doesn't match")
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