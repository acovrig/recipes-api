FactoryBot.define do
  factory :picture do
    association :recipe, factory: :recipe
    fname { Faker::File.file_name }
    sum { Faker::Internet.password(32, 32) }
    width { Faker::Number.between(480, 1920) }
    height { Faker::Number.between(480, 1280) }
    size { Faker::Number.between(1024, 209715200) }
  end
end