require 'rails_helper'

RSpec.describe StacksController, type: :controller do
  let(:valid_attributes) do
    attributes_for(:stack01)
  end

  let(:invalid_attributes) do
    attributes_for(:invalid_stack)
  end

  let(:valid_session) { {} }

  describe 'GET #index' do
    it 'assigns all stacks as @stacks' do
      @user = create(:unlock_user)
      sign_in @user
      stack = Stack.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:stacks)).to eq([stack])
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested stack' do
      @user = create(:unlock_user)
      sign_in @user
      stack = Stack.create! valid_attributes
      expect { delete :destroy, { id: stack.to_param }, valid_session }
        .to change(Stack, :count).by(-1)
    end

    it 'redirects to the stacks list' do
      @user = create(:unlock_user)
      sign_in @user
      stack = Stack.create! valid_attributes
      delete :destroy, { id: stack.to_param }, valid_session
      expect(response).to redirect_to(stacks_url)
    end
  end
end
