require 'rails_helper'

RSpec.describe Utensil, type: :model do
  context 'validation tests' do
    it 'should save' do
      utensil = FactoryBot.build(:utensil)
      expect(utensil.valid?).to eq(true)
    end
  end
end
