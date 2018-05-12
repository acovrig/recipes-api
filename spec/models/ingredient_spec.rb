require 'rails_helper'

RSpec.describe Ingredient, type: :model do
  context 'validation tests' do
    it 'requires a recipe' do
      ingredient = FactoryBot.build(:ingredient, recipe: nil)
      expect(ingredient.valid?).to eq(false)
    end

    it 'requires an item' do
      ingredient = FactoryBot.build(:ingredient, item: nil)
      expect(ingredient.valid?).to eq(false)
    end

    it 'requires a unique item' do
      recipe = FactoryBot.create(:recipe)
      item = Faker::Food.spice
      FactoryBot.create(:ingredient, recipe: recipe, item: item)
      ingredient = FactoryBot.build(:ingredient, recipe: recipe, item: item)
      expect(ingredient.valid?).to eq(false)
    end

    it 'should save' do
      ingredient = FactoryBot.build(:ingredient)
      expect(ingredient.valid?).to eq(true)
    end
  end
end
