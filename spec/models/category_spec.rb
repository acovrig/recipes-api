require 'rails_helper'

RSpec.describe Category, type: :model do
  context 'validation tests' do
    it 'should save' do
      category = FactoryBot.build(:category)
      expect(category.valid?).to eq(true)
    end
  end
end
