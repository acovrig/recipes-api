FactoryBot.define do
  sequence :name do |n|
    "#{Faker::Food.dish}-#{n}"
  end
  factory :recipe do
    name
    association :author, factory: :user
    serving_size { Faker::Number.between(1, 10) }
    serving_suggestion { Faker::Food.measurement }
    rating { Faker::Number.between(1, 5) }
    privacy { ['public', 'internal', 'unlisted', 'private'].sample }
  end
end