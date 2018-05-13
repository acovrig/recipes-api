class Utensil < ApplicationRecord
  belongs_to :recipe
  validates :name, presence: true
  validates :name, uniqueness: {scope: [:recipe_id]}
end
