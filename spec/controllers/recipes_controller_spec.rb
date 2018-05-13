require 'rails_helper'

RSpec.describe RecipesController, type: :controller do
  context 'GET #index' do
    it 'returns a success' do
      get :index
      expect(response).to be_success
    end
    it 'returns a success with login' do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = FactoryBot.create(:user)
      sign_in user
      get :index
      expect(response).to be_success
    end
  end

  context 'GET #show' do
    it 'returns a success' do
      recipe = FactoryBot.create(:recipe, privacy: 'public')
      get :show, params: { id: recipe.id }
      expect(response).to be_success
    end
    it 'succeeds with a public recipe' do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = FactoryBot.create(:user)
      sign_in user
      recipe = FactoryBot.create(:recipe, privacy: 'public')
      get :show, params: { id: recipe.id }
      expect(response).to be_success
    end
    it 'succeeds with an internal recipe' do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = FactoryBot.create(:user)
      sign_in user
      recipe = FactoryBot.create(:recipe, privacy: 'internal')
      get :show, params: { id: recipe.id }
      expect(response).to be_success
    end
    it 'fails with a private recipe I do not own' do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = FactoryBot.create(:user)
      sign_in user
      recipe = FactoryBot.create(:recipe, privacy: 'private')
      get :show, params: { id: recipe.id }
      assert_redirected_to recipes_path
    end
  end

  context 'GET #new' do
    it 'requires login' do
      get :new
      assert_redirected_to new_user_session_path
    end

    it 'works with login' do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = FactoryBot.create(:user)
      sign_in user
      get :new
      expect(response).to be_success
    end
  end

  context 'GET #edit' do
    it 'requires login' do
      @recipe = FactoryBot.create(:recipe)
      get :edit, params: { id: @recipe.id }
      assert_redirected_to new_user_session_path
    end

    it 'works with login (my recipe)' do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = FactoryBot.create(:user)
      sign_in user
      @recipe = FactoryBot.create(:recipe, author: user)
      get :edit, params: { id: @recipe.id }
      expect(response).to be_success
    end

    it 'fails with login (not my recipe)' do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = FactoryBot.create(:user)
      sign_in user
      @recipe = FactoryBot.create(:recipe)
      get :edit, params: { id: @recipe.id }
      assert_redirected_to root_path
    end
  end

  context 'POST #create' do
    it 'requires login' do
      @recipe = FactoryBot.build(:recipe)
      post :create, params: { recipe: @recipe }
      assert_redirected_to new_user_session_path
    end

    it 'works with login' do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = FactoryBot.create(:user)
      sign_in user
      @recipe = FactoryBot.build(:recipe)
      post :create, params: { recipe: @recipe.attributes }
      expect(response.status).to eq(302)
    end

    it 'fails with bad data' do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = FactoryBot.create(:user)
      sign_in user
      @recipe = FactoryBot.build(:recipe).attributes.except('name')
      post :create, params: { recipe: @recipe }
      expect(response).to be_success
    end
  end

  context 'PUT #update' do
    it 'requires login' do
      @recipe = FactoryBot.create(:recipe)
      @recipe_name = FactoryBot.build(:recipe).name
      put :update, params: { id: @recipe.id, recipe: {name: @recipe_name } }
      assert_redirected_to new_user_session_path
    end

    it 'works with login (my recipe)' do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = FactoryBot.create(:user)
      sign_in user
      @recipe = FactoryBot.create(:recipe, author: user)
      @recipe_name = FactoryBot.build(:recipe).name
      put :update, params: { id: @recipe.id, recipe: {name: @recipe_name } }
      assert_redirected_to recipe_path(@recipe)
    end

    it 'works with login (not my recipe)' do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = FactoryBot.create(:user)
      sign_in user
      @recipe = FactoryBot.create(:recipe)
      @recipe_name = FactoryBot.build(:recipe).name
      put :update, params: { id: @recipe.id, recipe: {name: @recipe_name } }
      assert_redirected_to root_path
    end

    it 'fails with bad data' do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = FactoryBot.create(:user)
      sign_in user
      @recipe = FactoryBot.create(:recipe, author: user)
      @recipe2 = FactoryBot.create(:recipe, author: user)
      put :update, params: { id: @recipe.id, recipe: {name: @recipe2.name } }
      expect(response).to be_success
    end
  end

  context 'DELETE #create' do
    it 'requires login' do
      @recipe = FactoryBot.create(:recipe)
      delete :destroy, params: { id: @recipe.id }
      assert_redirected_to new_user_session_path
    end

    it 'works with login (my recipe)' do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = FactoryBot.create(:user)
      sign_in user
      @recipe = FactoryBot.create(:recipe, author: user)
      delete :destroy, params: { id: @recipe.id }
      assert_redirected_to recipes_path
    end

    it 'works with login (not my recipe)' do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = FactoryBot.create(:user)
      sign_in user
      @recipe = FactoryBot.create(:recipe)
      delete :destroy, params: { id: @recipe.id }
      assert_redirected_to root_path
    end
  end
end
