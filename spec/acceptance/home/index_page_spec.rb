require 'rails_helper'
require 'acceptance_helper'

feature 'Home page', %q{
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
end
