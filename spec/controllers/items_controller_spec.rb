require 'rails_helper'

RSpec.describe ItemsController, type: :controller do
  include_context 'users'

  let(:category) { create(:category, user_id: user.id) }
  describe 'POST #create' do
    let(:form_params) { {} }
    let(:params) do
      {
        category_id: category.id,
        item: attributes_for(:item, user: user, category: category).merge(form_params)
      }
    end

    subject { post :create, params: params }

    it_behaves_like 'when user is unauthorized' do
      it { expect { subject }.to_not change(Item, :count) }
      it { expect(subject).to redirect_to root_path }
    end

    it_behaves_like 'when user is authorized' do
      it { expect { subject }.to change(Item, :count) }

      it_behaves_like 'invalid params concern', 'empty title', model: Item do
        let(:form_params) { { title: '' } }
      end

      it_behaves_like 'invalid params concern', 'empty description', model: Item do
        let(:form_params) { { description: '' } }
      end
    end
  end

  describe 'PATCH update' do
    let(:item) { create(:item, user_id: user.id, category_id: category.id) }

    let(:form_params) do
      {
        title: 'b' * 6,
        description: 'z' * 6
      }
    end

    let(:params) do
      {
        id: item.id,
        item: attributes_for(:item).merge(form_params)
      }
    end

    subject do
      patch :update, params: params
      item.reload
    end

    it_behaves_like 'when user is unauthorized' do
      before { subject }
      it { expect(category.title).to_not eql params[:item][:title] }
      it { expect(category.title).to_not eql params[:item][:title] }
    end

    it_behaves_like 'when user is authorized' do
      before { subject }
      it { expect(item.title).to eql params[:item][:title] }
      it { expect(item.description).to eql params[:item][:description] }

      it_behaves_like 'invalid params concern', 'empty title', model: Item do
        let(:form_params) { { title: '' } }
        before { subject }
      end

      it_behaves_like 'invalid params concern', 'empty description', model: Item do
        let(:form_params) { { description: '' } }
        before { subject }
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:item) { create(:item, user_id: user.id, category_id: category.id) }

    subject do
      delete :destroy, params: { id: item.id }
    end

    it_behaves_like 'when user is unauthorized' do
      it { expect { subject }.to_not change(Item, :count) }
      it { expect(subject).to redirect_to root_path }
    end

    it_behaves_like 'when user is authorized' do
      it { expect { subject }.to change { Item.count }.by(-1) }
      it { expect(subject).to redirect_to category_items_path(category_id: category.id) }
    end
  end

  describe 'GET #index' do
    let(:items) { create_list(:item, 2, user: user, category_id: category.id) }
    before { get :index, params: { category_id: category.id } }

    it 'list all' do
      expect(assigns(:items)).to match_array(items)
    end

    it 'renders the index template' do
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    let(:item) { create(:item, user_id: user.id, category_id: category.id) }

    before { get :show, params: { id: item.id } }

    it 'render the show template' do
      expect(response).to render_template :show
    end

    it { expect(assigns(:item)).to eq item }
  end

  describe 'GET #new' do
    subject { get :new, params: { category_id: category.id } }

    it_behaves_like 'when user is authorized' do
      before { subject }

      it 'assigns new item to @item' do
        expect(assigns(:item)).to be_a_new(Item)
      end

      it 'renders the new template' do
        expect(response).to render_template :new
      end
    end

    it_behaves_like 'when user is unauthorized' do
      before { subject }

      it 'renders the new template' do
        expect(response).to redirect_to root_path
      end
    end
  end

  describe 'GET #edit' do
    let(:item) { create(:item, user_id: user.id, category_id: category.id) }

    let(:params) do
      {
        id: item.id
      }
    end

    subject { get :edit, params: params }

    it_behaves_like 'when user is authorized' do
      before { subject }
      it { expect(response).to render_template(:edit) }
      it { expect(assigns(:item)).to eq item }
    end

    it_behaves_like 'when user is unauthorized' do
      before { subject }
      it { expect(response).to redirect_to(root_path) }
    end
  end
end
