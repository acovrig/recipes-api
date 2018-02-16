Rails.application.routes.draw do
  root      'recipes#index'
  resources :recipes do
    resources :utensils
    resources :notes
    resources :pictures
    resources :directions
    resources :ingredients
  end
  resources :categories
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
