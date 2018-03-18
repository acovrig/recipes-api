class Recipe < ApplicationRecord
    has_many :recipe_categories
    has_many :categories, through: :recipe_categories
    has_many :directions
    has_many :ingredients
    has_many :utensils
    has_many :notes
    has_many :pictures

    accepts_nested_attributes_for :directions, reject_if: :all_blank, allow_destroy: true
end
