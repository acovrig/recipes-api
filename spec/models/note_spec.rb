require 'rails_helper'

RSpec.describe Note, type: :model do
  context 'validation tests' do
    it 'should save' do
      note = FactoryBot.build(:note)
      expect(note.valid?).to eq(true)
    end
  end
end
