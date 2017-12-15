require 'rails_helper'

RSpec.describe Item, type: :model do
  it { should belong_to(:category) }
  it { should belong_to(:user) }
  it { should have_many(:black_lists) }
  it { should have_many(:suggestions).dependent(:destroy) }
  it { should validate_presence_of :title }
  it { should validate_presence_of :description }
  it { should validate_presence_of :picture }
  it { should validate_uniqueness_of(:title).case_insensitive }

  it do
    should validate_attachment_content_type(:picture)
      .allowing('image/png', 'image/gif', 'image/jpg', 'image/jpeg')
  end

  include_context 'users'

  describe 'scope: things_of_other' do
    let(:categories) { create_list(:category, 2, user_id: user.id) }
    let!(:items) do
      categories.each { |i| create_list(:item, 3, category_id: i.id, user_id: user.id) }
    end
    let!(:john_items) do
      categories.each { |i| create_list(:item, 5, category_id: i.id, user_id: john.id) }
    end

    it { expect(Item.things_of_other(user)).to match_array(john.items) }
    it { expect(Item.things_of_other(john)).to match_array(user.items) }
  end

  describe 'scope: with_category' do
    let(:categories) { create_list(:category, 2, user_id: user.id) }
    let!(:items) do
      categories.each { |i| create_list(:item, 3, category_id: i.id, user_id: user.id) }
    end

    it { expect(Item.with_category(categories.first.id)).to match_array(Item.where(category_id: categories.first.id)) }
  end

  describe 'scope: text_search' do
    let(:categories) { create_list(:category, 2, user_id: user.id) }
    let!(:items) do
      categories.each { |i| create_list(:item, 3, category_id: i.id, user_id: user.id) }
    end

    it do
      expect(Item.text_search(Item.last.title.last(4)).take).to eq Item.last
    end
    it do
      expect(Item.text_search(Item.last.description.last(4)).take).to eq Item.last
    end
  end
end
