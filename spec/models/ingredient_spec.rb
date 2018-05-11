require 'rails_helper'

RSpec.describe Ingredient, type: :model do
  context 'validation tests' do
    it 'should save' do
      ingredient = FactoryBot.build(:ingredient)
      expect(ingredient.valid?).to eq(true)
    end
  end
end
