require 'rails_helper'

RSpec.describe UtensilsController, type: :controller do
  before(:each) do
    @recipe = FactoryBot.create(:recipe)
  end

  context 'GET #index' do
    it 'requires login' do
      get :index, params: { recipe_id: @recipe.id }
      assert_redirected_to new_user_session_path
    end

    it 'works with login (my recipe)' do
      sign_in @recipe.author
      @request.env["devise.mapping"] = Devise.mappings[:user]
      get :index, params: { recipe_id: @recipe.id }
      expect(response).to be_success
    end

    it 'fails with login (not my recipe)' do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = FactoryBot.create(:user)
      sign_in user
      get :index, params: { recipe_id: @recipe.id }
      assert_redirected_to recipes_path
    end
  end

  context 'GET #new' do
    it 'requires login' do
      get :new, params: { recipe_id: @recipe.id }
      assert_redirected_to new_user_session_path
    end

    it 'works with login (my recipe)' do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in @recipe.author
      get :new, params: { recipe_id: @recipe.id }
      expect(response).to be_success
    end

    it 'fails with login (not my recipe)' do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = FactoryBot.create(:user)
      sign_in user
      get :new, params: { recipe_id: @recipe.id }
      assert_redirected_to recipes_path
    end
  end

  context 'GET #edit' do
    it 'requires login' do
      @utensil = FactoryBot.create(:utensil)
      get :edit, params: { recipe_id: @recipe.id, id: @utensil.id }
      assert_redirected_to new_user_session_path
    end

    it 'works with login (my recipe)' do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in @recipe.author
      @utensil = FactoryBot.create(:utensil, recipe: @recipe)
      get :edit, params: { recipe_id: @recipe.id, id: @utensil.id }
      expect(response).to be_success
    end

    it 'fails with login (not my recipe)' do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = FactoryBot.create(:user)
      sign_in user
      @utensil = FactoryBot.create(:utensil)
      get :edit, params: { recipe_id: @recipe.id, id: @utensil.id }
      assert_redirected_to recipes_path
    end
  end

  context 'GET #search' do
    it 'returns success' do
      @utensil = FactoryBot.create(:utensil)
      get :search, params: { q: @utensil.name }
      expect(response).to be_success
    end
    it 'returns success logged in' do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = FactoryBot.create(:user)
      sign_in user
      @utensil = FactoryBot.create(:utensil)
      get :search, params: { q: @utensil.name }
      expect(response).to be_success
    end
  end

  context 'POST #create' do
    it 'requires login' do
      @utensil = FactoryBot.build(:utensil)
      post :create, params: { recipe_id: @recipe.id, utensil: @utensil }
      assert_redirected_to new_user_session_path
    end

    it 'works with login (my recipe)' do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in @recipe.author
      @utensil = FactoryBot.build(:utensil, recipe: @recipe)
      post :create, params: { recipe_id: @recipe.id, utensil: @utensil.attributes }
      expect(response.status).to eq(302)
    end

    it 'fails with login (not my recipe)' do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = FactoryBot.create(:user)
      sign_in user
      @utensil = FactoryBot.build(:utensil)
      post :create, params: { recipe_id: @recipe.id, utensil: @utensil.attributes }
      expect(response.status).to eq(302)
    end

    it 'fails with bad data' do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in @recipe.author
      @utensil = FactoryBot.build(:utensil).attributes.except('name')
      post :create, params: { recipe_id: @recipe.id, utensil: @utensil }
      expect(response).to be_success
    end
  end

  context 'PUT #update' do
    it 'requires login' do
      @utensil = FactoryBot.create(:utensil)
      @utensil2 = FactoryBot.build(:utensil, recipe: @recipe)
      put :update, params: { recipe_id: @recipe.id, id: @utensil.id, utensil: {name: @utensil2.name } }
      assert_redirected_to new_user_session_path
    end

    it 'works with login (my recipe)' do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in @recipe.author
      @utensil = FactoryBot.create(:utensil, recipe: @recipe)
      @utensil2 = FactoryBot.build(:utensil, recipe: @recipe)
      put :update, params: { recipe_id: @recipe.id, id: @utensil.id, utensil: {name: @utensil2.name } }
      assert_redirected_to recipe_utensil_path(@recipe, @utensil)
    end

    it 'fails with login (not my recipe)' do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = FactoryBot.create(:user)
      sign_in user
      @utensil = FactoryBot.create(:utensil, recipe: @recipe)
      @utensil2 = FactoryBot.build(:utensil, recipe: @recipe)
      put :update, params: { recipe_id: @recipe.id, id: @utensil.id, utensil: {name: @utensil2.name } }
      assert_redirected_to recipes_path
    end

    it 'fails with bad data' do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in @recipe.author
      @utensil = FactoryBot.create(:utensil, recipe: @recipe)
      @utensil2 = FactoryBot.create(:utensil, recipe: @recipe)
      put :update, params: { recipe_id: @recipe.id, id: @utensil.id, utensil: {name: @utensil2.name } }
      expect(response).to be_success
    end
  end

  context 'DELETE #create' do
    it 'requires login' do
      @utensil = FactoryBot.create(:utensil)
      delete :destroy, params: { recipe_id: @recipe.id, id: @utensil.id }
      assert_redirected_to new_user_session_path
    end

    it 'works with login (my recipe)' do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in @recipe.author
      @utensil = FactoryBot.create(:utensil, recipe: @recipe)
      delete :destroy, params: { recipe_id: @recipe.id, id: @utensil.id }
      assert_redirected_to recipe_utensils_path(@recipe)
    end

    it 'works with login (not my recipe)' do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = FactoryBot.create(:user)
      sign_in user
      @utensil = FactoryBot.create(:utensil)
      delete :destroy, params: { recipe_id: @recipe.id, id: @utensil.id }
      assert_redirected_to recipes_path
    end
  end
end
