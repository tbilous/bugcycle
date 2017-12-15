require 'rails_helper'
require 'acceptance_helper'

feature 'Suggestions', %q{
  As user
    as not owner
      I can to add suggestion
      I can to delete suggestion
    as owner
      I do not can to add suggestion
      I can to apply suggestion
      I can to delete suggestion
  As quest
     I do not can to add suggestion
} do

  include_context 'users'
  let(:category) { create(:category, user_id: user.id) }
  let!(:item) { create(:item, user_id: john.id, category_id: category.id) }

  context 'As user', :js do
    scenario 'as not item owner' do
      Capybara.using_session('user') do
        login_as(user)

        visit item_path(item.id)

        expect(page).to have_link t('add_suggestion')
        click_on t('add_suggestion')

        expect(page).to have_content t('suggestions.edit.title')

        within 'form' do
          fill_in 'suggestion_title', with: 'My awesome suggestion'
          fill_in 'suggestion_description', with: 'My awesome  suggestion description'
          attach_file 'suggestion_picture', "#{Rails.root}/spec/support/for_upload/other_picture.png"

          click_on t('save')
        end

        expect(page).to have_content t('items.show.suggestion_title') + ':'
        expect(page).to_not have_link t('add_suggestion')

        within '.suggestion-card' do
          expect(page).to have_content 'My awesome suggestion'
          expect(page).to have_content 'My awesome  suggestion description'
          expect(page).to have_link t('delete_suggestion')
        end
      end
      Capybara.using_session('john') do
        login_as(john)

        visit item_path(item.id)
        expect(page).to_not have_link t('add_suggestion')
        expect(page).to have_link t('delete_suggestion')
        expect(page).to have_link t('apply_suggestion')
        click_on t('apply_suggestion')

        expect(page).to_not have_content item.title
        expect(page).to_not have_content item.description
      end

      Capybara.using_session('bill') do
        login_as(bill)

        visit item_path(item.id)
        expect(page).to have_link t('add_suggestion')
        expect(page).to_not have_link t('delete_suggestion')
        expect(page).to_not have_link t('apply_suggestion')
      end

      Capybara.using_session('quest') do
        visit item_path(item.id)

        expect(page).to_not have_link t('add_suggestion')
        expect(page).to_not have_link t('delete_suggestion')
        expect(page).to_not have_link t('apply_suggestion')
      end
    end
  end
end
