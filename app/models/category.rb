class Category < ApplicationRecord
    validates :name, uniqueness: true
    has_many :recipe_categories
    has_many :recipies, through: :recipe_categories
end
