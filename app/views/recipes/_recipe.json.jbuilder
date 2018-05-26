json.extract! recipe, :id, :name, :author, :servings, :serving_suggestion, :rating, :created_at, :updated_at
json.url recipe_url(recipe, format: :json)
