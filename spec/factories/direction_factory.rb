FactoryBot.define do
  factory :direction do
    association :recipe, factory: :recipe
    step { Faker::Number.between(1, 5) }
    action { Faker::Hacker.verb }
  end
end