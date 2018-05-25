Rails.application.routes.draw do
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
  get 'utensils/search', to: 'utensils#search', as: 'search_utensil'
  get 'notes/search', to: 'notes#search', as: 'search_note'
  get 'ingredients/search', to: 'ingredients#search', as: 'search_ingredient'
  get 'author/:id', to: 'home#author', as: 'author'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
