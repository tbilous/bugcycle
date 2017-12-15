require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  include_context 'users'

  describe 'POST #create' do
    let(:form_params) { {} }
    let(:params) do
      {
        category: attributes_for(:category, user: user).merge(form_params)
      }
    end

    subject { post :create, params: params }

    it_behaves_like 'when user is unauthorized' do
      it { expect { subject }.to_not change(Category, :count) }
      it { expect(subject).to redirect_to root_path }
    end

    it_behaves_like 'when user is authorized' do
      it { expect { subject }.to change(Category, :count) }

      it_behaves_like 'invalid params concern', 'empty title', model: Category do
        let(:form_params) { { title: '' } }
      end
    end
  end

  describe 'PATCH update' do
    let(:category) { create(:category, user_id: user.id) }

    let(:form_params) do
      {
        title: 'b' * 6
      }
    end

    let(:params) do
      {
        id: category.id,
        category: attributes_for(:category, user_ud: user.id).merge(form_params)
      }
    end

    subject do
      patch :update, params: params
      category.reload
    end

    it_behaves_like 'when user is unauthorized' do
      before { subject }
      it { expect(category.title).to_not eql params[:category][:title] }
    end

    it_behaves_like 'when user is authorized' do
      before { subject }
      it { expect(category.title).to_not eql params[:category][:title] }

      it_behaves_like 'invalid params concern', 'empty title', model: Category do
        let(:form_params) { { title: '' } }
        before { subject }
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:category) { create(:category, user_id: user.id) }

    subject do
      delete :destroy, params: { id: category.id }
    end

    it_behaves_like 'when user is unauthorized' do
      it { expect { subject }.to_not change(Category, :count) }
      it { expect(subject).to redirect_to root_path }
    end

    it_behaves_like 'when user is authorized' do
      it { expect { subject }.to_not change(Category, :count) }
      it { expect(subject).to redirect_to root_path }
    end
  end

  describe 'GET #index' do
    let(:categories) { create_list(:category, 2, user: user) }
    before { get :index }

    it 'list all' do
      expect(assigns(:categories)).to match_array(categories)
    end

    it 'renders the index template' do
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    let(:category) { create(:category, user_id: user.id) }

    before { get :show, params: { id: category.id } }

    it 'render the show template' do
      expect(response).to render_template :show
    end

    it { expect(assigns(:category)).to eq category }
  end

  describe 'GET #new' do
    subject { get :new }

    it_behaves_like 'when user is authorized' do
      before { subject }

      it 'assigns new category to @category' do
        expect(assigns(:category)).to be_a_new(Category)
      end

      it 'renders the new template' do
        expect(response).to render_template :new
      end
    end

    it_behaves_like 'when user is unauthorized' do
      before { subject }
      it { expect(response).to redirect_to(root_path) }
    end
  end

  describe 'GET #edit' do
    let(:category) { create(:category, user_id: user.id) }

    let(:params) do
      {
        id: category.id
      }
    end

    subject { get :edit, params: params }

    it_behaves_like 'when user is authorized' do
      before { subject }
      it { expect(response).to redirect_to(root_path) }
    end

    it_behaves_like 'when user is unauthorized' do
      before { subject }
      it { expect(response).to redirect_to(root_path) }
    end
  end
end
