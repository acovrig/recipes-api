class Picture < ApplicationRecord
  belongs_to :recipe
  belongs_to :uploaded_by, class_name: 'User'

  has_attached_file :pic, styles: { medium: "400x400>", thmb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :pic, content_type: /\Aimage\/.*\z/

  validates :sum, :width, :height, presence: true
  validates :sum, uniqueness: true
end
