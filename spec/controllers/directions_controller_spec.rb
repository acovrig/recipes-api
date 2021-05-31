require 'rails_helper'

RSpec.describe DirectionsController, type: :controller do
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
      @request.env['devise.mapping'] = Devise.mappings[:user]
      get :index, params: { recipe_id: @recipe.id }
      expect(response).to be_success
    end

    it 'fails with login (not my recipe)' do
      @request.env['devise.mapping'] = Devise.mappings[:user]
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
      @request.env['devise.mapping'] = Devise.mappings[:user]
      sign_in @recipe.author
      get :new, params: { recipe_id: @recipe.id }
      expect(response).to be_success
    end

    it 'fails with login (not my recipe)' do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      user = FactoryBot.create(:user)
      sign_in user
      get :new, params: { recipe_id: @recipe.id }
      assert_redirected_to recipes_path
    end
  end

  context 'GET #edit' do
    it 'requires login' do
      @direction = FactoryBot.create(:direction)
      get :edit, params: { recipe_id: @recipe.id, id: @direction.id }
      assert_redirected_to new_user_session_path
    end

    it 'works with login (my recipe)' do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      sign_in @recipe.author
      @direction = FactoryBot.create(:direction, recipe: @recipe)
      get :edit, params: { recipe_id: @recipe.id, id: @direction.id }
      expect(response).to be_success
    end

    it 'fails with login (not my recipe)' do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      user = FactoryBot.create(:user)
      sign_in user
      @direction = FactoryBot.create(:direction)
      get :edit, params: { recipe_id: @recipe.id, id: @direction.id }
      assert_redirected_to recipes_path
    end
  end

  context 'POST #create' do
    it 'requires login' do
      @direction = FactoryBot.build(:direction)
      post :create, params: { recipe_id: @recipe.id, direction: @direction }
      assert_redirected_to new_user_session_path
    end

    it 'works with login (my recipe)' do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      sign_in @recipe.author
      @direction = FactoryBot.build(:direction, recipe: @recipe)
      post :create, params: { recipe_id: @recipe.id, direction: @direction.attributes }
      expect(response.status).to eq(302)
    end

    it 'fails with login (not my recipe)' do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      user = FactoryBot.create(:user)
      sign_in user
      @direction = FactoryBot.build(:direction)
      post :create, params: { recipe_id: @recipe.id, direction: @direction.attributes }
      expect(response.status).to eq(302)
    end

    it 'fails with bad data' do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      sign_in @recipe.author
      @direction = FactoryBot.build(:direction).attributes.except('action')
      post :create, params: { recipe_id: @recipe.id, direction: @direction }
      expect(response).to be_success
    end
  end

  context 'PUT #update' do
    it 'requires login' do
      @direction = FactoryBot.create(:direction)
      @direction2 = FactoryBot.build(:direction, recipe: @recipe)
      put :update, params: { recipe_id: @recipe.id, id: @direction.id, direction: { action: @direction2.action } }
      assert_redirected_to new_user_session_path
    end

    it 'works with login (my recipe)' do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      sign_in @recipe.author
      @direction = FactoryBot.create(:direction, recipe: @recipe)
      @direction2 = FactoryBot.build(:direction, recipe: @recipe)
      put :update, params: { recipe_id: @recipe.id, id: @direction.id, direction: { action: @direction2.action } }
      assert_redirected_to recipe_direction_path(@recipe, @direction)
    end

    it 'fails with login (not my recipe)' do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      user = FactoryBot.create(:user)
      sign_in user
      @direction = FactoryBot.create(:direction, recipe: @recipe)
      @direction2 = FactoryBot.build(:direction, recipe: @recipe)
      put :update, params: { recipe_id: @recipe.id, id: @direction.id, direction: { action: @direction2.action } }
      assert_redirected_to recipes_path
    end

    it 'fails with bad data' do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      sign_in @recipe.author
      @direction = FactoryBot.create(:direction, recipe: @recipe)
      @direction2 = FactoryBot.create(:direction, recipe: @recipe)
      put :update, params: { recipe_id: @recipe.id, id: @direction.id, direction: { action: @direction2.action } }
      expect(response).to be_success
    end
  end

  context 'DELETE #create' do
    it 'requires login' do
      @direction = FactoryBot.create(:direction)
      delete :destroy, params: { recipe_id: @recipe.id, id: @direction.id }
      assert_redirected_to new_user_session_path
    end

    it 'works with login (my recipe)' do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      sign_in @recipe.author
      @direction = FactoryBot.create(:direction, recipe: @recipe)
      delete :destroy, params: { recipe_id: @recipe.id, id: @direction.id }
      assert_redirected_to recipe_directions_path(@recipe)
    end

    it 'works with login (not my recipe)' do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      user = FactoryBot.create(:user)
      sign_in user
      @direction = FactoryBot.create(:direction)
      delete :destroy, params: { recipe_id: @recipe.id, id: @direction.id }
      assert_redirected_to recipes_path
    end
  end
end
