class Direction < ApplicationRecord
  belongs_to :recipe
  validates :step, :action, presence: true
  validates :recipe_id, uniqueness: {scope: [:step]}
end
