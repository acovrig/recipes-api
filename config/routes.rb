Rails.application.routes.draw do
  # NOTE: be *sure* to run `rails js:routes` anytime this file gets modified...
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root      'home#index'
  resources :recipes do
    member do
      put 'categories', to: 'recipes#categories'
    end
    resources :utensils
    resources :notes
    resources :pictures
    resources :directions
    resources :ingredients
  end
  resources :categories
  get 'search', to: 'home#search', as: 'search'
  get 'search/inventory', to: 'home#inventory', as: 'inventory_search'
  get 'utensils/search', to: 'utensils#search', as: 'search_utensil'
  get 'notes/search', to: 'notes#search', as: 'search_note'
  get 'ingredients/search', to: 'ingredients#search', as: 'search_ingredient'
  get 'author/:id', to: 'home#author', as: 'author'

  namespace :api, defaults: { format: :json } do
    scope :v1 do
      mount_devise_token_auth_for 'User', at: 'auth'
      resources :recipes do
        member do
          put 'categories', to: 'recipes#categories'
        end
        resources :utensils
        resources :notes
        resources :pictures
        resources :directions
        resources :ingredients
      end
      resources :categories
      get 'search', to: 'home#search', as: 'search'
      get 'search/inventory', to: 'home#inventory', as: 'inventory_search'
      get 'utensils/search', to: 'utensils#search', as: 'search_utensil'
      get 'notes/search', to: 'notes#search', as: 'search_note'
      get 'ingredients/search', to: 'ingredients#search', as: 'search_ingredient'
      get 'author/:id', to: 'home#author', as: 'author'
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
