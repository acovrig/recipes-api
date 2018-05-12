require 'rails_helper'

RSpec.describe Category, type: :model do
  context 'validation tests' do
    it 'requires a name' do
      category = FactoryBot.build(:category, name: nil)
      expect(category.valid?).to eq(false)
    end

    it 'requires a unique name' do
      name = Faker::Name.name
      FactoryBot.create(:category, name: name)
      category = FactoryBot.build(:category, name: name)
      expect(category.valid?).to eq(false)
    end

    it 'should save' do
      category = FactoryBot.build(:category)
      expect(category.valid?).to eq(true)
    end
  end
end
