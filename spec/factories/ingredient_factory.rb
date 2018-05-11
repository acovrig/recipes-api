FactoryBot.define do
  factory :ingredient do
    association :recipe, factory: :recipe
    qty { Faker::Number.between(1, 10) }
    unit { Faker::Measurement.height("none") }
    item { Faker::Food.spice }
    note { Faker::Lorem.sentence }
  end
end