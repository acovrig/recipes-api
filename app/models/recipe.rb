class Recipe < ApplicationRecord
  before_save :normalize_blank_values
  belongs_to :author, class_name: 'User'
  has_many :recipe_categories
  has_many :categories, through: :recipe_categories
  has_many :directions
  has_many :ingredients
  has_many :utensils
  has_many :pictures
  has_many :notes

  validates :name, :privacy, presence: true
  validates :name, uniqueness: true

  accepts_nested_attributes_for :directions, :ingredients, :utensils, reject_if: :all_blank, allow_destroy: true

  scope :public_recipes, -> { where(privacy: 'public') }
  scope :internal_recipes, -> { where(privacy: 'internal') }
  scope :unlisted_recipes, -> { where(privacy: 'unlisted') }
  scope :private_recipes, -> { where(privacy: 'private') }

  private
    def normalize_blank_values
      attributes.each do |col, val|
        self[col].present? || self[col] = nil
      end
    end
end
