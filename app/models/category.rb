class Category < ApplicationRecord
  belongs_to :created_by, class_name: 'User'
  has_many :recipe_categories
  has_many :recipes, through: :recipe_categories
  validates :name, presence: true
  validates :name, uniqueness: true
end
