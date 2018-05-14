FactoryBot.define do
  factory :picture do
    association :recipe, factory: :recipe
    association :uploaded_by, factory: :user
    pic { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'support', 'images', 'test_image.jpg'), 'image/jpeg') }
    sum { Faker::Internet.password(32, 32) }
    width { Faker::Number.between(480, 1920) }
    height { Faker::Number.between(480, 1280) }
    size { Faker::Number.between(1024, 209715200) }
    caption { Faker::Lorem.sentence }
  end
end