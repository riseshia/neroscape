require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  describe 'GET #index' do
    it 'responds redirected to /users/sign_in' do
      get :index

      expect(response).to redirect_to('/users/sign_in')
    end

    it 'renders the index template' do
      @user = create(:unlock_user)
      sign_in @user

      get :index
      expect(response).to render_template('index')
    end

    it 'should not accessible to lock user' do
      @user = create(:lock_user)
      sign_in @user

      get :index
      expect(response).to redirect_to('/home/locked')
    end
  end
end
