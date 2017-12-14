require 'rails_helper'

RSpec.describe BlackListsController, type: :controller do
  include_context 'users'

  let(:category) { create(:category, user_id: user.id) }
  let(:user_item) { create(:item, category_id: category.id, user_id: user.id) }
  let(:john_item) { create(:item, category_id: category.id, user_id: john.id) }

  describe 'POST #create' do
    it_behaves_like 'when user is authorized' do
      describe 'when user is not item owner' do
        subject { post :create, params: { item_id: john_item.id }, format: :json }

        it { expect { subject }.to change(BlackList, :count).by(1) }
      end

      describe 'when user is item owner' do
        subject { post :create, params: { item_id: user_item.id }, format: :json }

        it { expect { subject }.to_not change(BlackList, :count) }
      end

      describe 'when user is not item owner but had black_list' do
        let!(:black_list) { create(:black_list, user_id: user.id, item_id: john_item.id) }

        subject { post :create, params: { item_id: john_item.id }, format: :json }

        it { expect { subject }.to_not change(BlackList, :count) }
      end

      describe 'when user is not item owner but had other black_list' do
        let!(:black_list) { create(:black_list, user_id: john.id, item_id: john_item.id) }

        subject { post :create, params: { item_id: john_item.id }, format: :json }

        it { expect { subject }.to change(BlackList, :count).by(1) }
      end
    end
    it_behaves_like 'when user is unauthorized' do
      subject { post :create, params: { item_id: user_item.id }, format: :json }

      it { expect { subject }.to_not change(BlackList, :count) }
    end
  end

  describe 'DELETE #destroy' do
    describe 'when user is owner black_list' do
      let!(:black_list) { create(:black_list, user_id: user.id, item_id: john_item.id) }
      it_behaves_like 'when user is authorized' do
        subject { delete :destroy, params: { id: black_list.id }, format: :json }

        it { expect { subject }.to change(BlackList, :count).by(-1) }
      end
    end

    describe 'when user not is owner black_list' do
      let!(:black_list) { create(:black_list, user_id: john.id, item_id: user_item.id) }
      it_behaves_like 'when user is authorized' do
        subject { delete :destroy, params: { id: black_list.id }, format: :json }
        it { expect { subject }.to_not change(BlackList, :count) }
      end
    end

    it_behaves_like 'when user is unauthorized' do
      let!(:black_list) { create(:black_list, user_id: user.id, item_id: user_item.id) }
      subject { delete :destroy, params: { id: black_list.id }, format: :json }

      it { expect { subject }.to_not change(BlackList, :count) }
    end
  end
end
