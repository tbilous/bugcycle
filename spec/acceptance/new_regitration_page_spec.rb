require 'rails_helper'
require 'acceptance_helper'

feature 'New registration', %q{
  As a user
  I want to register
} do

  include_context 'users'
  context 'as user' do
    scenario 'Create profile' do
      visit new_user_registration_path
      within '#new_user' do
        fill_in 'user_email', with: 'test2test231@test.com'
        fill_in 'user_password', with: 'foobar'
        fill_in 'user_password_confirmation', with: 'foobar'
        click_on t('devise.registrations.new.sign_up')
      end
      expect(page).to have_content t('devise.registrations.signed_up')
    end
  end
end
