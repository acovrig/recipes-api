class Recipe < ApplicationRecord
    has_many :recipe_categories
    has_many :categories, through: :recipe_categories
    has_many :directions
    has_many :ingredients
    has_many :utensils
    has_many :pictures
    has_many :notes

    validates :name, presence: true
    validates :name, uniqueness: true

    accepts_nested_attributes_for :directions, :ingredients, reject_if: :all_blank, allow_destroy: true
end
