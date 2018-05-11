require 'rails_helper'

RSpec.describe Direction, type: :model do
  context 'validation tests' do
    it 'requires a recipe' do
      direction = FactoryBot.build(:direction, recipe: nil)
      expect(direction.valid?).to eq(false)
    end

    it 'requires a step' do
      direction = FactoryBot.build(:direction, step: nil)
      expect(direction.valid?).to eq(false)
    end

    it 'requires an action' do
      direction = FactoryBot.build(:direction, action: nil)
      expect(direction.valid?).to eq(false)
    end

    it 'should save' do
      direction = FactoryBot.build(:direction)
      expect(direction.valid?).to eq(true)
    end
  end
end
