require 'rails_helper'

RSpec.describe SearchesController, type: :controller do
  include_context 'users'
  describe 'GET #search' do
    let(:categories) { create_list(:category, 2, user_id: user.id) }

    it_behaves_like 'when user is unauthorized' do
      let!(:items) do
        categories.each { |i| create_list(:item, 5, category_id: i.id, user_id: [user.id, john.id].sample) }
      end
      let(:item) { Item.all.sample }
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

    it_behaves_like 'when user is authorized' do
      describe 'search if not owner of items' do
        let!(:items) do
          categories.each { |i| create_list(:item, 5, category_id: i.id, user_id: john.id) }
        end
        let(:item) { Item.all.sample }
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
        describe 'if item blacklisted' do
          let!(:black_list) { create(:black_list, user_id: user.id, item_id: item.id) }
          before { get :search, params: { text: item.title }, format: :json }

          it { expect(response.body).to have_json_size(0) }
        end
      end
      describe 'search if owner of items' do
        let!(:items) do
          categories.each { |i| create_list(:item, 5, category_id: i.id, user_id: user.id) }
        end
        let(:item) { Item.all.sample }
        describe 'search by title' do
          before { get :search, params: { text: item.title }, format: :json }
          it { expect(response.body).to have_json_size(0) }
        end
        describe 'search by description' do
          before { get :search, params: { text: item.description }, format: :json }
          it { expect(response.body).to have_json_size(0) }
        end
      end
    end
  end
end
