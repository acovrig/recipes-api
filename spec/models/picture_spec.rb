require 'rails_helper'

RSpec.describe Picture, type: :model do
  context 'validation tests' do
    it 'requires a recipe' do
      picture = FactoryBot.build(:picture, recipe: nil)
      expect(picture.valid?).to eq(false)
    end

    it 'requires a fname' do
      picture = FactoryBot.build(:picture, fname: nil)
      expect(picture.valid?).to eq(false)
    end

    it 'requires a unique fname' do
      recipe = FactoryBot.create(:recipe)
      fname = FactoryBot.build(:picture).fname
      FactoryBot.create(:picture, recipe: recipe, fname: fname)
      picture = FactoryBot.build(:picture, recipe: recipe, fname: fname)
      expect(picture.valid?).to eq(false)
    end

    it 'requires a sum' do
      picture = FactoryBot.build(:picture, sum: nil)
      expect(picture.valid?).to eq(false)
    end

    it 'requires a unique sum' do
      recipe = FactoryBot.create(:recipe)
      sum = FactoryBot.build(:picture).sum
      FactoryBot.create(:picture, recipe: recipe, sum: sum)
      picture = FactoryBot.build(:picture, recipe: recipe, sum: sum)
      expect(picture.valid?).to eq(false)
    end

    it 'should save' do
      picture = FactoryBot.build(:picture)
      expect(picture.valid?).to eq(true)
    end
  end
end
