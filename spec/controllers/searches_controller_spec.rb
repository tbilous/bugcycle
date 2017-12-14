require 'rails_helper'

RSpec.describe SearchesController, type: :controller do
  include_context 'users'
  describe 'GET #search' do
    let(:categories) { create_list(:category, 2, user_id: user.id) }
    let!(:items) do
      categories.each { |i| create_list(:item, 5, category_id: i.id, user_id: [user.id, john.id].sample) }
    end
    let(:item) { Item.all.sample }

    it_behaves_like 'when user is unauthorized' do
      describe 'search by title' do
        before { get :search, params: { text: item.title }, format: :json }
        it { expect(response.body).to have_json_size(1) }
        it do
          expect(JSON.parse(response.body)[0]['title']).to eq(item.title)
          expect(JSON.parse(response.body)[0]['description']).to eq(item.description)
        end
      end
      describe 'search by description' do
        before { get :search, params: { text: item.description }, format: :json }
        it { expect(response.body).to have_json_size(1) }
        it do
          expect(JSON.parse(response.body)[0]['title']).to eq(item.title)
          expect(JSON.parse(response.body)[0]['description']).to eq(item.description)
        end
      end
    end
  end
end
