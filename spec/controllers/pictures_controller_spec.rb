require 'rails_helper'

RSpec.describe PicturesController, type: :controller do
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
      @picture = FactoryBot.create(:picture)
      get :edit, params: { recipe_id: @recipe.id, id: @picture.id }
      assert_redirected_to new_user_session_path
    end

    it 'works with login (my recipe)' do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in @recipe.author
      @picture = FactoryBot.create(:picture, recipe: @recipe)
      get :edit, params: { recipe_id: @recipe.id, id: @picture.id }
      expect(response).to be_success
    end

    it 'fails with login (not my recipe)' do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = FactoryBot.create(:user)
      sign_in user
      @picture = FactoryBot.create(:picture)
      get :edit, params: { recipe_id: @recipe.id, id: @picture.id }
      assert_redirected_to recipes_path
    end
  end

  context 'POST #create' do
    it 'requires login' do
      @picture = FactoryBot.build(:picture)
      post :create, params: { recipe_id: @recipe.id, picture: @picture }
      assert_redirected_to new_user_session_path
    end

    it 'works with login (my recipe)' do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in @recipe.author
      @picture = FactoryBot.build(:picture, recipe: @recipe)
      post :create, params: { recipe_id: @recipe.id, picture: @picture.attributes }
      expect(response.status).to eq(302)
    end

    it 'fails with login (not my recipe)' do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = FactoryBot.create(:user)
      sign_in user
      @picture = FactoryBot.build(:picture)
      post :create, params: { recipe_id: @recipe.id, picture: @picture.attributes }
      expect(response.status).to eq(302)
    end

    it 'fails with bad data' do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in @recipe.author
      @picture = FactoryBot.build(:picture).attributes.except('fname')
      post :create, params: { recipe_id: @recipe.id, picture: @picture }
      expect(response).to be_success
    end
  end

  context 'PUT #update' do
    it 'requires login' do
      @picture = FactoryBot.create(:picture)
      @picture2 = FactoryBot.build(:picture, recipe: @recipe)
      put :update, params: { recipe_id: @recipe.id, id: @picture.id, picture: {fname: @picture2.fname } }
      assert_redirected_to new_user_session_path
    end

    it 'works with login (my recipe)' do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in @recipe.author
      @picture = FactoryBot.create(:picture, recipe: @recipe)
      @picture2 = FactoryBot.build(:picture, recipe: @recipe)
      put :update, params: { recipe_id: @recipe.id, id: @picture.id, picture: {fname: @picture2.fname } }
      assert_redirected_to recipe_picture_path(@recipe, @picture)
    end

    it 'fails with login (not my recipe)' do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = FactoryBot.create(:user)
      sign_in user
      @picture = FactoryBot.create(:picture, recipe: @recipe)
      @picture2 = FactoryBot.build(:picture, recipe: @recipe)
      put :update, params: { recipe_id: @recipe.id, id: @picture.id, picture: {fname: @picture2.fname } }
      assert_redirected_to recipes_path
    end

    it 'fails with bad data' do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in @recipe.author
      @picture = FactoryBot.create(:picture, recipe: @recipe)
      @picture2 = FactoryBot.create(:picture, recipe: @recipe)
      put :update, params: { recipe_id: @recipe.id, id: @picture.id, picture: {fname: @picture2.fname } }
      expect(response).to be_success
    end
  end

  context 'DELETE #create' do
    it 'requires login' do
      @picture = FactoryBot.create(:picture)
      delete :destroy, params: { recipe_id: @recipe.id, id: @picture.id }
      assert_redirected_to new_user_session_path
    end

    it 'works with login (my recipe)' do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in @recipe.author
      @picture = FactoryBot.create(:picture, recipe: @recipe)
      delete :destroy, params: { recipe_id: @recipe.id, id: @picture.id }
      assert_redirected_to recipe_pictures_path(@recipe)
    end

    it 'works with login (not my recipe)' do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = FactoryBot.create(:user)
      sign_in user
      @picture = FactoryBot.create(:picture)
      delete :destroy, params: { recipe_id: @recipe.id, id: @picture.id }
      assert_redirected_to recipes_path
    end
  end
end
