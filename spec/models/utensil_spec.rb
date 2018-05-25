require 'rails_helper'

RSpec.describe Utensil, type: :model do
  context 'validation tests' do
    it 'requires an name' do
      utensil = FactoryBot.build(:utensil, name: nil)
      expect(utensil.valid?).to eq(false)
    end
    it 'requires a qty' do
      utensil = FactoryBot.build(:utensil, qty: nil)
      expect(utensil.valid?).to eq(false)
    end
    it 'should save' do
      utensil = FactoryBot.build(:utensil)
      expect(utensil.valid?).to eq(true)
    end
  end
end
