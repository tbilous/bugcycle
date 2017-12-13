require 'rails_helper'
require 'acceptance_helper'

feature 'New registration', %q{
  As user
  I want to register
} do

  include_context 'users'
  context 'as user' do
    scenario 'Create profile' do
      visit root_path
      expect(page).to_not have_content t('sign_out')
      click_on t('sign_up')

      within '#new_user' do
        fill_in 'user_email', with: 'test2test231@test.com'
        fill_in 'user_password', with: 'foobar'
        fill_in 'user_password_confirmation', with: 'foobar'
        click_on t('devise.registrations.new.sign_up')
      end
      expect(page).to have_content t('devise.registrations.signed_up')
      expect(page).to have_content t('sign_out')
    end
  end
end
