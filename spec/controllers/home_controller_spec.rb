require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  context 'GET #search' do
    it 'returns a success' do
      get :search, params: { search: 'potato' }
      expect(response).to be_success
    end
    it 'returns a success signed in' do
      user = FactoryBot.create(:user)
      sign_in user
      get :search, params: { search: 'potato' }
      expect(response).to be_success
    end
  end

  context 'GET #author' do
    it 'returns a success' do
      user = FactoryBot.create(:user)
      get :author, params: { id: user.id }
      expect(response).to be_success
    end
    it 'returns a success signed in' do
      user = FactoryBot.create(:user)
      sign_in user
      get :author, params: { id: user.id }
      expect(response).to be_success
    end
  end
end
