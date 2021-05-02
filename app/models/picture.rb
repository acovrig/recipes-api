class Picture < ApplicationRecord
  belongs_to :recipe
  belongs_to :uploaded_by, class_name: 'User'

  validates :sum, :width, :height, presence: true
  validates :sum, uniqueness: true
end
