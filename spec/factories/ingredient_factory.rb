FactoryBot.define do
  sequence :item do |n|
    "#{Faker::Food.spice}-#{n}"
  end
  factory :ingredient do
    association :recipe, factory: :recipe
    qty { Faker::Number.between(1, 10) }
    unit { Faker::Measurement.height("none") }
    item
    note { Faker::Lorem.sentence }
  end
end