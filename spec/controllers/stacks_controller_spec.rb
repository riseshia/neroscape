require 'rails_helper'

RSpec.describe StacksController, type: :controller do
  let(:valid_attributes) do
    attributes_for(:stack01)
  end

  let(:invalid_attributes) do
    attributes_for(:invalid_stack)
  end

  let(:valid_session) { {} }

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
      it 'assigns all stacks as @stacks' do
        stack = Stack.create! valid_attributes
        get :index, {}, valid_session
        expect(assigns(:stacks)).to eq([stack])
      end
    end

    describe 'POST #create' do
      context 'with valid params' do
        it 'creates a new Stack' do
          expect do
            post :create, stack: valid_attributes, game_id: 1
          end.to change(Stack, :count).by(1)
        end

        it 'assigns a newly created stack as @stack' do
          post :create, stack: valid_attributes, game_id: 1
          expect(assigns(:stack)).to be_a(Stack)
          expect(assigns(:stack)).to be_persisted
        end
      end
    end

    describe 'DELETE #destroy' do
      it 'destroys the requested stack' do
        stack = Stack.create! valid_attributes
        expect { delete :destroy, { id: stack.to_param }, valid_session }
          .to change(Stack, :count).by(-1)
      end
    end
  end
end
