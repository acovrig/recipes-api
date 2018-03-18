class Direction < ApplicationRecord
  belongs_to :recipe
  validates :step, presence: true
  validates :recipe_id, uniqueness: {scope: [:step]}
end
