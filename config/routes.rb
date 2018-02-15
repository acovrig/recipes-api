Rails.application.routes.draw do
  resources :notes
  resources :pictures
  resources :directions
  resources :ingredients
  resources :recipe_categories
  resources :categories
  resources :recipes
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
