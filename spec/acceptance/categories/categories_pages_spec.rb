require 'rails_helper'
require 'acceptance_helper'

feature 'New registration', %q{
  As user
  I can to add category
  I do not to create category with the same name
  I can to edit category
  I can to delete category
  I can see categories list
  As quest
  I can see categories list
  I can not make delete, edit, create actions
} do

  include_context 'users'
  let!(:categories) { create_list(:category, 2, user_id: user.id) }

  context 'As user', :js do
    scenario 'I can Add edit destroy category' do
      visit_user(user)

      click_on t('activerecord.models.category.other')
      within '#CategoryNavGroup' do
        click_on t('new')
      end

      expect(current_path).to eq new_category_path

      within '#new_category' do
        fill_in 'category_title', with: 'My awesome category'
        click_on t('save')
      end

      wait_animation
      expect(page).to have_content t('flash.actions.create.notice', resource_name: 'Category')
      expect(current_path).to eq category_path(Category.find_by_title('My awesome category'))
      expect(page).to have_content 'My awesome category'

      click_on t('activerecord.models.category.other')
      within '#CategoryNavGroup' do
        click_on t('new')
      end

      #  user does not to create category with the same name
      within '#new_category' do
        fill_in 'category_title', with: 'my awesome category'
        click_on t('save')
      end

      wait_animation
      expect(page).to have_content t('flash.actions.create.alert', resource_name: 'Category')

      click_on t('activerecord.models.category.other')

      within '#CategoryNavGroup' do
        click_on t('list')
      end

      expect(current_path).to eq categories_path

      click_on 'My awesome category'

      expect(current_path).to eq category_path(Category.find_by_title('My awesome category'))
      click_on t('edit')

      within 'form' do
        fill_in 'category_title', with: 'My awesome category have changes'
        click_on t('save')
      end

      expect(current_path).to eq category_path(Category.find_by_title('My awesome category have changes'))
      wait_animation
      expect(page).to have_content t('flash.actions.update.notice', resource_name: 'Category')

      click_on t('delete')

      expect(current_path).to eq categories_path
      wait_animation
      expect(page).to have_content t('flash.actions.destroy.notice', resource_name: 'Category')
      expect(page).to_not have_content 'My awesome category'
      expect(page).to_not have_content 'My awesome category have changes'
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

      categories.each do |i|
        expect(page).to have_link i.title
      end
      click_on Category.first.title

      expect(page).to_not have_content t('delete')
      expect(page).to_not have_content t('edit')
    end
  end
end
