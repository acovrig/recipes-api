require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  context 'GET #search' do
    it 'returns a success' do
      get :search, params: { search: 'potato' }
      expect(response).to be_success
    end
  end
end
