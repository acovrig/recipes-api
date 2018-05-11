require 'rails_helper'

RSpec.describe Recipe, type: :model do
  context 'validation tests' do
    it 'requires a name' do
      recipe = FactoryBot.build(:recipe, name: nil)
      expect(recipe.valid?).to eq(false)
    end

    it 'requires a unique name' do
      name = Faker::Name.name
      FactoryBot.create(:recipe, name: name)
      recipe = FactoryBot.build(:recipe, name: name)
      expect(recipe.valid?).to eq(false)
    end

    it 'requires an author' do
      recipe = FactoryBot.build(:recipe, author: nil)
      expect(recipe.valid?).to eq(false)
    end

    it 'requires an privacy specification' do
      recipe = FactoryBot.build(:recipe, privacy: nil)
      expect(recipe.valid?).to eq(false)
    end

    it 'should save' do
      recipe = FactoryBot.build(:recipe)
      expect(recipe.valid?).to eq(true)
    end
  end

  context 'scope tests' do
    before(:each) do
      FactoryBot.create(:recipe, privacy: 'private')
      FactoryBot.create(:recipe, privacy: 'private')
      FactoryBot.create(:recipe, privacy: 'internal')
      FactoryBot.create(:recipe, privacy: 'unlisted')
      FactoryBot.create(:recipe, privacy: 'unlisted')
      FactoryBot.create(:recipe, privacy: 'unlisted')
      FactoryBot.create(:recipe, privacy: 'public')
      FactoryBot.create(:recipe, privacy: 'public')
      FactoryBot.create(:recipe, privacy: 'public')
      FactoryBot.create(:recipe, privacy: 'public')
      FactoryBot.create(:recipe, privacy: 'public')
    end

    it 'should have private recipes' do
      expect(Recipe.private_recipes.size).to eq(2)
    end

    it 'should have internal recipes' do
      expect(Recipe.internal_recipes.size).to eq(1)
    end

    it 'should have unlisted recipes' do
      expect(Recipe.unlisted_recipes.size).to eq(3)
    end

    it 'should have public recipes' do
      expect(Recipe.public_recipes.size).to eq(5)
    end
  end
end
