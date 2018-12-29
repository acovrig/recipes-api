json.partial! "recipes/recipe", recipe: @recipe
json.ingredients @recipe.ingredients
json.utensils @recipe.utensils
json.directions @recipe.directions