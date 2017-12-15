require 'rails_helper'

RSpec.describe SuggestionsController, type: :controller do
  include_context 'users'

  let(:category) { create(:category, user_id: user.id) }
  let(:item) { create(:item, user_id: user.id, category_id: category.id) }
  let(:john_item) { create(:item, user_id: john.id, category_id: category.id) }

  describe 'POST #create' do
    it_behaves_like 'when user is unauthorized' do
      subject { post :create, params: { item_id: john_item.id } }
      it { expect { subject }.to_not change(Suggestion, :count) }
      it { expect(subject).to redirect_to root_path }
    end

    it_behaves_like 'when user is authorized' do
      describe 'when user not is owner of item' do
        subject { post :create, params: { item_id: john_item.id } }
        it { expect { subject }.to change(Suggestion, :count).by(1) }
        it { expect(subject).to redirect_to edit_suggestion_path(user.suggestions.last.id) }
      end
      describe 'when user is owner of item' do
        subject { post :create, params: { item_id: item.id } }
        it { expect { subject }.to_not change(Suggestion, :count) }
        it { expect(subject).to redirect_to item_path(item.id) }
      end
    end
  end

  describe 'PATCH update' do
    let(:user_suggestion) do
      create(:suggestion, user_id: user.id,
                          author_id: john_item.user_id,
                          item_id: john_item.id,
                          category_id: john_item.category.id,
                          item_picture: john_item.picture.url(:original))
    end

    let(:john_suggestion) do
      create(:suggestion, user_id: john.id,
                          author_id: item.user_id,
                          item_id: item.id,
                          category_id: item.category.id,
                          item_picture: item.picture.url(:original))
    end

    let(:form_params) do
      {
        title: 'b' * 6,
        description: 'z' * 6
      }
    end

    it_behaves_like 'when user is unauthorized' do
      let(:params) do
        {
          id: user_suggestion.id,
          suggestion: attributes_for(:suggestion).merge(form_params)
        }
      end

      subject do
        patch :update, params: params
        user_suggestion.reload
      end

      before { subject }
      it { expect(user_suggestion.title).to_not eql params[:suggestion][:title] }
      it { expect(user_suggestion.title).to_not eql params[:suggestion][:description] }
      it { expect(subject).to redirect_to root_path }
    end

    it_behaves_like 'when user is authorized' do
      describe 'when user is suggestion owner' do
        let(:params) do
          {
            id: user_suggestion.id,
            suggestion: attributes_for(:suggestion).merge(form_params)
          }
        end

        subject do
          patch :update, params: params
          user_suggestion.reload
        end

        before { subject }
        it { expect(user_suggestion.title).to eql params[:suggestion][:title] }
        it { expect(user_suggestion.description).to eql params[:suggestion][:description] }

        it_behaves_like 'invalid params concern', 'empty title', model: Item do
          let(:form_params) { { title: '' } }
          before { subject }
        end

        it_behaves_like 'invalid params concern', 'empty description', model: Item do
          let(:form_params) { { description: '' } }
          before { subject }
        end
      end

      describe 'when user not is suggestion owner' do
        let(:params) do
          {
            id: john_suggestion.id,
            suggestion: attributes_for(:suggestion).merge(form_params)
          }
        end

        subject do
          patch :update, params: params
          john_suggestion.reload
        end

        it { expect(john_suggestion.title).to_not eql params[:suggestion][:title] }
        it { expect(john_suggestion.description).to_not eql params[:suggestion][:description] }
        it { expect(subject).to redirect_to root_path }
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:user_suggestion) do
      create(:suggestion, user_id: user.id,
                          author_id: john_item.user_id,
                          item_id: john_item.id,
                          category_id: john_item.category.id,
                          item_picture: john_item.picture.url(:original))
    end

    let!(:john_suggestion) do
      create(:suggestion, user_id: john.id,
                          author_id: item.user_id,
                          item_id: item.id,
                          category_id: item.category.id,
                          item_picture: item.picture.url(:original))
    end

    let!(:bill_suggestion) do
      create(:suggestion, user_id: bill.id,
                          author_id: john_item.user_id,
                          item_id: john_item.id,
                          category_id: john_item.category.id,
                          item_picture: john_item.picture.url(:original))
    end

    it_behaves_like 'when user is unauthorized' do
      subject do
        delete :destroy, params: { id: user_suggestion.id }
      end

      it { expect { subject }.to_not change(Suggestion, :count) }
      it { expect(subject).to redirect_to root_path }
    end

    it_behaves_like 'when user is authorized' do
      describe 'when user is suggestion owner' do
        subject do
          delete :destroy, params: { id: user_suggestion.id }
        end

        it { expect { subject }.to change { Suggestion.count }.by(-1) }
        it { expect(subject).to redirect_to item_path(user_suggestion.item_id) }
      end

      describe 'when user not is suggestion owner but item owner' do
        subject do
          delete :destroy, params: { id: john_suggestion.id }
        end

        it { expect { subject }.to change { Suggestion.count }.by(-1) }
        it { expect(subject).to redirect_to item_path(john_suggestion.item_id) }
      end

      describe 'when user not is suggestion and item owner' do
        subject do
          delete :destroy, params: { id: bill_suggestion.id }
        end

        it { expect { subject }.to_not change(Suggestion, :count) }
        it { expect(subject).to redirect_to root_path }
      end
    end
  end

  describe 'GET #edit' do
    let!(:user_suggestion) do
      create(:suggestion, user_id: user.id,
                          author_id: john_item.user_id,
                          item_id: john_item.id,
                          category_id: john_item.category.id,
                          item_picture: john_item.picture.url(:original))
    end

    let!(:john_suggestion) do
      create(:suggestion, user_id: john.id,
                          author_id: item.user_id,
                          item_id: item.id,
                          category_id: item.category.id,
                          item_picture: item.picture.url(:original))
    end

    it_behaves_like 'when user is unauthorized' do
      subject do
        get :edit, params: { id: user_suggestion.id }
      end
      before { subject }

      it { expect(subject).to redirect_to root_path }
    end

    it_behaves_like 'when user is authorized' do
      describe 'when user is suggestion owner' do
        subject do
          get :edit, params: { id: user_suggestion.id }
        end
        before { subject }

        it { expect(response).to render_template(:edit) }
        it { expect(assigns(:suggestion)).to eq user_suggestion }
      end

      describe 'when user not is suggestion  owner' do
        subject do
          get :edit, params: { id: john_suggestion.id }
        end
        before { subject }

        it { expect(subject).to redirect_to root_path }
      end
    end
  end
end
