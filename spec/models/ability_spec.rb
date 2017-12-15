require 'rails_helper'
require 'cancan/matchers'

RSpec.describe Ability, type: :model do
  subject(:ability) { Ability.new(user) }

  describe 'for guest' do
    let(:user) { nil }

    it { should be_able_to :read, Category }
    it { should be_able_to :read, Item }
    it { should_not be_able_to :manage, :all }
  end

  describe 'for user' do
    include_context 'users'

    let(:user_category) { create(:category, user_id: user.id) }
    let(:user_item) { create(:item, user_id: user.id, category_id: user_category.id) }
    let(:john_category) { create(:category, user_id: john.id) }
    let(:john_item) { create(:item, user_id: john.id, category_id: user_category.id) }
    let(:user_black_list) { create(:black_list, user_id: user.id, item_id: john_item.id) }
    let(:john_black_list) { create(:black_list, user_id: john.id, item_id: user_item.id) }
    let(:suggestion) do
      create(:suggestion, user_id: john.id, author_id: user.id, item_id: user_item.id,
                          category_id: user_item.category.id)
    end
    let(:bill_suggestion) do
      create(:suggestion, user_id: bill.id, author_id: john.id, item_id: john_item.id,
                          category_id: john_item.category.id)
    end

    it { should be_able_to :read, :all }
    it { should_not be_able_to :manage, :all }

    it { should be_able_to :create, Category }
    it { should be_able_to :create, Item }
    it { should be_able_to :create, BlackList }
    it { should be_able_to :create, Suggestion }

    context 'update' do
      it { should be_able_to :update, user_category }
      it { should be_able_to :update, john_category }
      it { should be_able_to :update, user_item }
      it { should_not be_able_to :update, john_item }
    end

    context 'destroy' do
      it { should be_able_to :destroy, user_category }
      it { should be_able_to :destroy, john_category }
      it { should be_able_to :destroy, user_item }
      it { should be_able_to :destroy, user_black_list }
      it { should be_able_to :destroy, suggestion }
      it { should_not be_able_to :destroy, john_item }
      it { should_not be_able_to :destroy, john_black_list }
      it { should_not be_able_to :destroy, bill_suggestion }
    end

    it { should be_able_to :me, User }
  end
end
