class Direction < ApplicationRecord
  belongs_to :recipe
  validates :step, :action, presence: true
  validates :step, uniqueness: {scope: [:recipe_id]}
  validates :action, uniqueness: {scope: [:recipe_id]}
end
