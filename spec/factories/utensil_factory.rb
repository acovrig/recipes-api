FactoryBot.define do
  factory :utensil do
    association :recipe, factory: :recipe
    name { Faker::Food.spice }
    qty { Faker::Number.between(1, 10) }
  end
end