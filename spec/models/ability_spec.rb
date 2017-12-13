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

    it { should be_able_to :read, :all }
    it { should_not be_able_to :manage, :all }

    it { should be_able_to :create, Category }
    it { should be_able_to :create, Item }

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
      it { should_not be_able_to :destroy, john_item }
    end

    it { should be_able_to :me, User }
  end
end
