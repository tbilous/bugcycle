require 'rails_helper'
require 'acceptance_helper'

feature 'New registration', %q{
  As user
  I can to add item
  I do not to create item with the same name
  I can to edit item
  I can to delete item
  I can see item list
  As quest
  I can see item list
  I can not make delete, edit, create actions
} do

  include_context 'users'
  let(:category) { create(:category, user_id: user.id) }
  let!(:item) { create(:item, user_id: user.id, category_id: category.id) }

  context 'As user', :js do
    scenario 'I can Add edit destroy item' do
      visit_user(user)

      click_on t('activerecord.models.category.other')
      within '#CategoryNavGroup' do
        click_on t('list')
      end

      click_on category.title
      click_on t('item.add')

      within '#new_item' do
        fill_in 'item_title', with: 'My awesome item'
        fill_in 'item_description', with: 'My awesome description'
        attach_file 'item_picture', "#{Rails.root}/spec/support/for_upload/no_picture.png"

        click_on t('save')
      end

      wait_animation
      expect(page).to have_content t('flash.actions.create.notice', resource_name: 'Item')
      expect(page).to have_content 'My awesome item'

      click_on t('edit')

      within 'form' do
        fill_in 'item_title', with: 'My awesome item edited'
        fill_in 'item_description', with: 'My awesome description edited'
        attach_file 'item_picture', "#{Rails.root}/spec/support/for_upload/no_picture.png"

        click_on t('save')
      end
      expect(current_path).to eq item_path(Item.find_by_title('My awesome item edited'))
      wait_animation
      expect(page).to have_content t('flash.actions.update.notice', resource_name: 'Item')
      expect(page).to have_content 'My awesome item edited'
      expect(page).to have_content 'My awesome description edited'
    end
  end
  context 'as guest', :js do
    scenario 'I can not make delete, edit, create actions' do
      visit root_path

      click_on t('activerecord.models.category.other')

      within '#CategoryNavGroup' do
        expect(page).to_not have_content t('new')
        click_on t('list')
      end

      click_on Category.first.title

      expect(page).to have_content item.title
      expect(page).to have_content item.description

      click_on item.title

      expect(current_path).to eq item_path(item.id)
      expect(page).to_not have_link t('delete')
      expect(page).to_not have_link t('edit')
    end
  end

  context 'As user John', :js do
    scenario 'I can`t edit destroy item created by user' do
      visit_user(john)

      click_on t('activerecord.models.category.other')
      within '#CategoryNavGroup' do
        click_on t('list')
      end

      click_on category.title
      click_on item.title

      expect(current_path).to eq item_path(item.id)

      expect(page).to_not have_link t('delete')
      expect(page).to_not have_link t('edit')
    end
  end
end
