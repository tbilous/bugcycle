require 'rails_helper'
require 'acceptance_helper'

feature 'Search', %q{
  As guest
  I want to find bicycle
  As user
  I want to find bicycle
} do

  include_context 'users'

  let(:categories) { create_list(:category, 2, user_id: user.id) }
  let!(:items) do
    categories.each { |i| create_list(:item, 10, category_id: i.id, user_id: [user.id, john.id].sample) }
  end
  let(:item) { Item.all.sample }

  include_context 'users'
  context 'As guest', :js do
    scenario 'Search bicycle' do
      visit root_path

      within '#searchForm' do
        fill_in 'text', with: Item.first.title
        find('#category_id').find(:xpath, 'option[1]').select_option
      end
      wait_animation
      expect(page).to have_css('.search-grid', count: 1)

      within '#searchForm' do
        fill_in 'text', with: ''
        find('#category_id').find(:xpath, 'option[1]').select_option
      end
      wait_animation
      expect(page).to have_css('.search-grid', count: 10)

      within '#searchForm' do
        find('#category_id').find(:xpath, 'option[1]').select_option
        find('#category_id').find(:xpath, 'option[2]').select_option
      end
      wait_animation
      expect(page).to have_link('2')
    end
  end
  context 'As user', :js do
    let!(:items) do
      categories.each { |i| create_list(:item, 5, category_id: i.id, user_id: john.id) }
    end
    scenario 'add remove item to search filter' do
      login_as user
      visit category_path(Category.first.id)

      first('.js-filter-on').trigger('click')

      expect(page).to have_link(t('remove_blacklist'))
      click_on t('remove_blacklist')
      wait_animation
      expect(page).to_not have_link(t('remove_blacklist'))
      expect(page).to have_link(t('add_blacklist'))
      first('.js-filter-on').trigger('click')

      visit root_path

      within '#searchForm' do
        fill_in 'text', with: BlackList.first.item.title
        find('#category_id').find(:xpath, 'option[1]').select_option
      end
      wait_animation
      expect(page).to_not have_css('.search-grid')
    end
  end
end
