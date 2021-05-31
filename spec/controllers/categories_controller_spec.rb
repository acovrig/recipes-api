require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  context 'GET #index' do
    it 'returns a success' do
      get :index
      expect(response).to be_success
    end
  end

  context 'GET #new' do
    it 'requires login' do
      get :new
      assert_redirected_to new_user_session_path
    end

    it 'works with login' do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      user = FactoryBot.create(:user)
      sign_in user
      get :new
      expect(response).to be_success
    end
  end

  context 'GET #edit' do
    it 'requires login' do
      @category = FactoryBot.create(:category)
      get :edit, params: { id: @category.id }
      assert_redirected_to new_user_session_path
    end

    it 'works with login (my recipe)' do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      user = FactoryBot.create(:user)
      sign_in user
      @category = FactoryBot.create(:category, created_by: user)
      get :edit, params: { id: @category.id }
      expect(response).to be_success
    end

    it 'fails with login (not my category)' do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      user = FactoryBot.create(:user)
      sign_in user
      @category = FactoryBot.create(:category)
      get :edit, params: { id: @category.id }
      assert_redirected_to root_path
    end
  end

  context 'GET #show' do
    it 'returns success' do
      @category = FactoryBot.create(:category)
      get :show, params: { id: @category.id }
      expect(response).to be_success
    end
    it 'returns success with login' do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      user = FactoryBot.create(:user)
      sign_in user
      @category = FactoryBot.create(:category, created_by: user)
      get :show, params: { id: @category.id }
      expect(response).to be_success
    end
  end

  context 'POST #create' do
    it 'requires login' do
      @category = FactoryBot.build(:category)
      post :create, params: { category: @category }
      assert_redirected_to new_user_session_path
    end

    it 'works with login' do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      user = FactoryBot.create(:user)
      sign_in user
      @category = FactoryBot.build(:category)
      post :create, params: { category: @category.attributes }
      expect(response.status).to eq(302)
    end

    it 'fails with bad data' do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      user = FactoryBot.create(:user)
      sign_in user
      @category = FactoryBot.build(:category).attributes.except('name')
      post :create, params: { category: @category }
      expect(response).to be_success
    end
  end

  context 'PUT #update' do
    it 'requires login' do
      @category = FactoryBot.create(:category)
      @category_name = FactoryBot.build(:category).name
      put :update, params: { id: @category.id, category: { name: @category_name } }
      assert_redirected_to new_user_session_path
    end

    it 'works with login (my category)' do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      user = FactoryBot.create(:user)
      sign_in user
      @category = FactoryBot.create(:category, created_by: user)
      @category_name = FactoryBot.build(:category).name
      put :update, params: { id: @category.id, category: { name: @category_name } }
      assert_redirected_to category_path(@category)
    end

    it 'works with login (not my category)' do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      user = FactoryBot.create(:user)
      sign_in user
      @category = FactoryBot.create(:category)
      @category_name = FactoryBot.build(:category).name
      put :update, params: { id: @category.id, category: { name: @category_name } }
      assert_redirected_to root_path
    end

    it 'fails with bad data' do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      user = FactoryBot.create(:user)
      sign_in user
      @category = FactoryBot.create(:category, created_by: user)
      @category2 = FactoryBot.create(:category, created_by: user)
      put :update, params: { id: @category.id, category: { name: @category2.name } }
      expect(response).to be_success
    end
  end

  context 'DELETE #create' do
    it 'requires login' do
      @category = FactoryBot.create(:category)
      delete :destroy, params: { id: @category.id }
      assert_redirected_to new_user_session_path
    end

    it 'works with login (my category)' do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      user = FactoryBot.create(:user)
      sign_in user
      @category = FactoryBot.create(:category, created_by: user)
      delete :destroy, params: { id: @category.id }
      assert_redirected_to categories_path
    end

    it 'works with login (not my category)' do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      user = FactoryBot.create(:user)
      sign_in user
      @category = FactoryBot.create(:category)
      delete :destroy, params: { id: @category.id }
      assert_redirected_to root_path
    end
  end
end
