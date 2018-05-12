class Picture < ApplicationRecord
  belongs_to :recipe

  validates :fname, :sum, :width, :height, presence: true
  validates :fname, uniqueness: true
  validates :sum, uniqueness: true
end
