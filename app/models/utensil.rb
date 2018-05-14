class Utensil < ApplicationRecord
  belongs_to :recipe
  validates :name, :qty, presence: true
  validates :name, uniqueness: {scope: [:recipe_id]}
end
