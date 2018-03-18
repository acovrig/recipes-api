class Ingredient < ApplicationRecord
  belongs_to :recipe
  validates :item, presence: true
  validates :item, uniqueness: {scope: [:recipe_id]}
end
