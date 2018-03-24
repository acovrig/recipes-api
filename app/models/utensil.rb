class Utensil < ApplicationRecord
  belongs_to :recipe
  validates :name, :recipe_id, presence: true
  validates :name, uniqueness: {scope: [:recipe_id]}
end
