require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validation tests' do
    it 'requires name' do
      user = FactoryBot.build(:user, name: nil)
      expect(user.valid?).to eq(false)
    end

    it 'requires email' do
      user = FactoryBot.build(:user, email: nil)
      expect(user.valid?).to eq(false)
    end

    it 'requires passwords match' do
      user = FactoryBot.build(:user, password_confirmation: Faker::Internet.password)
      expect(user.valid?).to eq(false)
    end

    it 'should save' do
      user = FactoryBot.build(:user)
      expect(user.valid?).to eq(true)
    end
  end
end
