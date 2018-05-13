require 'rails_helper'

RSpec.describe IngredientsController, type: :controller do
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

  context 'GET #search' do
    it 'returns success' do
      @ingredient = FactoryBot.create(:ingredient)
      get :search, params: { q: @ingredient.item }
      expect(response).to be_success
    end
    it 'returns success logged in' do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = FactoryBot.create(:user)
      sign_in user
      @ingredient = FactoryBot.create(:ingredient)
      get :search, params: { q: @ingredient.item }
      expect(response).to be_success
    end
  end

  context 'GET #edit' do
    it 'requires login' do
      @ingredient = FactoryBot.create(:ingredient)
      get :edit, params: { recipe_id: @recipe.id, id: @ingredient.id }
      assert_redirected_to new_user_session_path
    end

    it 'works with login (my recipe)' do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in @recipe.author
      @ingredient = FactoryBot.create(:ingredient, recipe: @recipe)
      get :edit, params: { recipe_id: @recipe.id, id: @ingredient.id }
      expect(response).to be_success
    end

    it 'fails with login (not my recipe)' do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = FactoryBot.create(:user)
      sign_in user
      @ingredient = FactoryBot.create(:ingredient)
      get :edit, params: { recipe_id: @recipe.id, id: @ingredient.id }
      assert_redirected_to recipes_path
    end
  end

  context 'POST #create' do
    it 'requires login' do
      @ingredient = FactoryBot.build(:ingredient)
      post :create, params: { recipe_id: @recipe.id, ingredient: @ingredient }
      assert_redirected_to new_user_session_path
    end

    it 'works with login (my recipe)' do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in @recipe.author
      @ingredient = FactoryBot.build(:ingredient, recipe: @recipe)
      post :create, params: { recipe_id: @recipe.id, ingredient: @ingredient.attributes }
      expect(response.status).to eq(302)
    end

    it 'fails with login (not my recipe)' do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = FactoryBot.create(:user)
      sign_in user
      @ingredient = FactoryBot.build(:ingredient)
      post :create, params: { recipe_id: @recipe.id, ingredient: @ingredient.attributes }
      expect(response.status).to eq(302)
    end

    it 'fails with bad data' do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in @recipe.author
      @ingredient = FactoryBot.build(:ingredient).attributes.except('item')
      post :create, params: { recipe_id: @recipe.id, ingredient: @ingredient }
      expect(response).to be_success
    end
  end

  context 'PUT #update' do
    it 'requires login' do
      @ingredient = FactoryBot.create(:ingredient)
      @ingredient2 = FactoryBot.build(:ingredient, recipe: @recipe)
      put :update, params: { recipe_id: @recipe.id, id: @ingredient.id, ingredient: {item: @ingredient2.item } }
      assert_redirected_to new_user_session_path
    end

    it 'works with login (my recipe)' do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in @recipe.author
      @ingredient = FactoryBot.create(:ingredient, recipe: @recipe)
      @ingredient2 = FactoryBot.build(:ingredient, recipe: @recipe)
      put :update, params: { recipe_id: @recipe.id, id: @ingredient.id, ingredient: {item: @ingredient2.item } }
      assert_redirected_to recipe_ingredient_path(@recipe, @ingredient)
    end

    it 'fails with login (not my recipe)' do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = FactoryBot.create(:user)
      sign_in user
      @ingredient = FactoryBot.create(:ingredient, recipe: @recipe)
      @ingredient2 = FactoryBot.build(:ingredient, recipe: @recipe)
      put :update, params: { recipe_id: @recipe.id, id: @ingredient.id, ingredient: {item: @ingredient2.item } }
      assert_redirected_to recipes_path
    end

    it 'fails with bad data' do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in @recipe.author
      @ingredient = FactoryBot.create(:ingredient, recipe: @recipe)
      @ingredient2 = FactoryBot.create(:ingredient, recipe: @recipe)
      put :update, params: { recipe_id: @recipe.id, id: @ingredient.id, ingredient: {item: @ingredient2.item } }
      expect(response).to be_success
    end
  end

  context 'DELETE #create' do
    it 'requires login' do
      @ingredient = FactoryBot.create(:ingredient)
      delete :destroy, params: { recipe_id: @recipe.id, id: @ingredient.id }
      assert_redirected_to new_user_session_path
    end

    it 'works with login (my recipe)' do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in @recipe.author
      @ingredient = FactoryBot.create(:ingredient, recipe: @recipe)
      delete :destroy, params: { recipe_id: @recipe.id, id: @ingredient.id }
      assert_redirected_to recipe_ingredients_path(@recipe)
    end

    it 'works with login (not my recipe)' do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = FactoryBot.create(:user)
      sign_in user
      @ingredient = FactoryBot.create(:ingredient)
      delete :destroy, params: { recipe_id: @recipe.id, id: @ingredient.id }
      assert_redirected_to recipes_path
    end
  end
end
