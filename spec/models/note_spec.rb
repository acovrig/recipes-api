require 'rails_helper'

RSpec.describe Note, type: :model do
  context 'validation tests' do
    it 'requires a recipe' do
      note = FactoryBot.build(:note, recipe: nil)
      expect(note.valid?).to eq(false)
    end

    it 'requires a note' do
      note = FactoryBot.build(:note, note: nil)
      expect(note.valid?).to eq(false)
    end

    it 'should save' do
      note = FactoryBot.build(:note)
      expect(note.valid?).to eq(true)
    end
  end
end
