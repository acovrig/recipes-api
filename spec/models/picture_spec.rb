require 'rails_helper'

RSpec.describe Picture, type: :model do
  context 'validation tests' do
    it 'should save' do
      picture = FactoryBot.build(:picture)
      expect(picture.valid?).to eq(true)
    end
  end
end
