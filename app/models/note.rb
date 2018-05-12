class Note < ApplicationRecord
  belongs_to :recipe
  validates :note, presence: true
end
