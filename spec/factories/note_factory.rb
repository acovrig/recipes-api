FactoryBot.define do
  factory :note do
    association :recipe, factory: :recipe
    note { Faker::Lorem.sentence }
  end
end