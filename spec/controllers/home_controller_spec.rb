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

  describe 'GET #locked' do
    it 'redirect unlocked user' do
      @user = create(:unlock_user)
      sign_in @user

      get :locked
      expect(response).to redirect_to('/')
    end

    it 'renders the locked template to locked user' do
      @user = create(:lock_user)
      sign_in @user

      get :locked
      expect(response).to render_template('locked')
    end
  end

  describe 'GET #search' do
    before(:example) do
      @user = create(:unlock_user)
      sign_in @user
    end

    it 'renders the search template' do
      get :search
      expect(response).to render_template('search')
    end

    it 'have 1 game as result' do
      create(:game)
      get :search, query: 'Dummy'
      expect(assigns(:games).size).to eq(1)
      expect(assigns(:brands)).to be_empty
      expect(assigns(:creators)).to be_empty
    end

    it 'have 1 brand as result' do
      Brand.create(name: 'Dummy')
      get :search, query: 'Dummy'
      expect(assigns(:games)).to be_empty
      expect(assigns(:brands).size).to eq(1)
      expect(assigns(:creators)).to be_empty
    end

    it 'have 1 creator as result' do
      Creator.create(name: 'Dummy')
      get :search, query: 'Dummy'
      expect(assigns(:games)).to be_empty
      expect(assigns(:brands)).to be_empty
      expect(assigns(:creators).size).to eq(1)
    end

    it 'have nothing as result' do
      get :search, query: ''
      expect(assigns(:games)).to be_nil
      expect(assigns(:brands)).to be_nil
      expect(assigns(:creators)).to be_nil
    end

    it 'have nothing as result' do
      get :search
      expect(assigns(:games)).to be_nil
      expect(assigns(:brands)).to be_nil
      expect(assigns(:creators)).to be_nil
    end
  end
end
