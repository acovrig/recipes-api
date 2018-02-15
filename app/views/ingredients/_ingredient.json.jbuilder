json.extract! ingredient, :id, :recipe_id, :qty, :unit, :item, :note, :created_at, :updated_at
json.url ingredient_url(ingredient, format: :json)
