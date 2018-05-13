FactoryBot.define do
  sequence :utensil_name do |n|
    "#{Faker::Food.spice}-#{n}"
  end
  factory :utensil do
    association :recipe, factory: :recipe
    name { generate(:utensil_name) }
    qty { Faker::Number.between(1, 10) }
  end
end