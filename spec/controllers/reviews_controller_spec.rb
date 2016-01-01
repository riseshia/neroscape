require 'rails_helper'

RSpec.describe ReviewsController, type: :controller do
  let(:valid_attributes) do
    attributes_for(:review)
  end

  let(:invalid_attributes) do
    attributes_for(:invalid_review)
  end

  context 'CASE: Not Sign-in' do
    describe 'GET #index' do
      it 'returns http redirect to ""' do
        get :index
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  context 'CASE: Sign-in' do
    before(:example) do
      @user = create(:unlock_user)
      sign_in @user
    end

    describe 'GET #index' do
      it 'renders the index template' do
        get :index
        expect(response).to render_template('index')
      end
    end

    describe 'GET #show' do
      it 'assigns the requested review as @review' do
        review = Review.create! valid_attributes
        get :show, id: review.to_param
        expect(assigns(:review)).to eq(review)
      end
    end

    describe 'GET #new' do
      it 'assigns a new review as @review' do
        get :new, {}
        expect(assigns(:review)).to be_a_new(Review)
      end
    end

    describe 'GET #edit' do
      it 'assigns the requested review as @review' do
        review = Review.create! valid_attributes
        get :edit, id: review.to_param
        expect(assigns(:review)).to eq(review)
      end
    end

    describe 'POST #create' do
      context 'with valid params' do
        it 'creates a new Review' do
          expect do
            post :create, review: valid_attributes
          end.to change(Review, :count).by(1)
        end

        it 'assigns a newly created review as @review' do
          post :create, review: valid_attributes
          expect(assigns(:review)).to be_a(Review)
          expect(assigns(:review)).to be_persisted
        end

        it 'redirects to the created review' do
          post :create, review: valid_attributes
          expect(response).to redirect_to(review_path(Review.last))
        end
      end

      context 'with invalid params' do
        it 'assigns a newly created but unsaved review as @review' do
          post :create, review: invalid_attributes
          expect(assigns(:review)).to be_a_new(Review)
        end

        it 're-renders the "new" template' do
          post :create, review: invalid_attributes
          expect(response).to render_template('new')
        end
      end
    end

    describe 'PUT #update' do
      context 'with valid params' do
        it 'updates the requested review' do
          review = Review.create! valid_attributes
          put :update, id: review.to_param, review: attributes_for(:review)
          review.reload
        end

        it 'assigns the requested review as @review' do
          review = Review.create! valid_attributes
          put :update, id: review.to_param, review: attributes_for(:review)
          expect(assigns(:review)).to eq(review)
        end

        it 'redirects to the review' do
          review = Review.create! valid_attributes
          put :update, id: review.to_param, review: attributes_for(:review)
          expect(response).to redirect_to(review_path(review))
        end
      end

      context 'with invalid params' do
        it 'assigns the review as @review' do
          review = Review.create! valid_attributes
          put :update, id: review.to_param, review: invalid_attributes
          expect(assigns(:review)).to eq(review)
        end

        it 're-renders the "edit" template' do
          review = Review.create! valid_attributes
          put :update, id: review.to_param, review: invalid_attributes
          expect(response).to render_template('edit')
        end
      end
    end

    describe 'DELETE #destroy' do
      it 'destroys the requested review' do
        review = Review.create! valid_attributes
        expect do
          delete :destroy, id: review.to_param
        end.to change(Review, :count).by(-1)
      end

      it 'redirects to the reviews list' do
        review = Review.create! valid_attributes
        delete :destroy, id: review.to_param
        expect(response).to redirect_to(reviews_url)
      end
    end
  end
end
