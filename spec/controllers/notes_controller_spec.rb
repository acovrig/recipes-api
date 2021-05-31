require 'rails_helper'

RSpec.describe NotesController, type: :controller do
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
      @note = FactoryBot.create(:note)
      get :edit, params: { recipe_id: @recipe.id, id: @note.id }
      assert_redirected_to new_user_session_path
    end

    it 'works with login (my recipe)' do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      sign_in @recipe.author
      @note = FactoryBot.create(:note, recipe: @recipe)
      get :edit, params: { recipe_id: @recipe.id, id: @note.id }
      expect(response).to be_success
    end

    it 'fails with login (not my recipe)' do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      user = FactoryBot.create(:user)
      sign_in user
      @note = FactoryBot.create(:note)
      get :edit, params: { recipe_id: @recipe.id, id: @note.id }
      assert_redirected_to recipes_path
    end
  end

  context 'POST #create' do
    it 'requires login' do
      @note = FactoryBot.build(:note)
      post :create, params: { recipe_id: @recipe.id, note: @note }
      assert_redirected_to new_user_session_path
    end

    it 'works with login (my recipe)' do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      sign_in @recipe.author
      @note = FactoryBot.build(:note, recipe: @recipe)
      post :create, params: { recipe_id: @recipe.id, note: @note.attributes }
      expect(response.status).to eq(302)
    end

    it 'fails with login (not my recipe)' do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      user = FactoryBot.create(:user)
      sign_in user
      @note = FactoryBot.build(:note)
      post :create, params: { recipe_id: @recipe.id, note: @note.attributes }
      expect(response.status).to eq(302)
    end

    it 'fails with bad data' do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      sign_in @recipe.author
      @note = FactoryBot.build(:note).attributes.except('note')
      post :create, params: { recipe_id: @recipe.id, note: @note }
      expect(response).to be_success
    end
  end

  context 'PUT #update' do
    it 'requires login' do
      @note = FactoryBot.create(:note)
      @note2 = FactoryBot.build(:note, recipe: @recipe)
      put :update, params: { recipe_id: @recipe.id, id: @note.id, note: { note: @note2.note } }
      assert_redirected_to new_user_session_path
    end

    it 'works with login (my recipe)' do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      sign_in @recipe.author
      @note = FactoryBot.create(:note, recipe: @recipe)
      @note2 = FactoryBot.build(:note, recipe: @recipe)
      put :update, params: { recipe_id: @recipe.id, id: @note.id, note: { note: @note2.note } }
      assert_redirected_to recipe_note_path(@recipe, @note)
    end

    it 'fails with login (not my recipe)' do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      user = FactoryBot.create(:user)
      sign_in user
      @note = FactoryBot.create(:note, recipe: @recipe)
      @note2 = FactoryBot.build(:note, recipe: @recipe)
      put :update, params: { recipe_id: @recipe.id, id: @note.id, note: { note: @note2.note } }
      assert_redirected_to recipes_path
    end
  end

  context 'DELETE #create' do
    it 'requires login' do
      @note = FactoryBot.create(:note)
      delete :destroy, params: { recipe_id: @recipe.id, id: @note.id }
      assert_redirected_to new_user_session_path
    end

    it 'works with login (my recipe)' do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      sign_in @recipe.author
      @note = FactoryBot.create(:note, recipe: @recipe)
      delete :destroy, params: { recipe_id: @recipe.id, id: @note.id }
      assert_redirected_to recipe_notes_path(@recipe)
    end

    it 'works with login (not my recipe)' do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      user = FactoryBot.create(:user)
      sign_in user
      @note = FactoryBot.create(:note)
      delete :destroy, params: { recipe_id: @recipe.id, id: @note.id }
      assert_redirected_to recipes_path
    end
  end
end
