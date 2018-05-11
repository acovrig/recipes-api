FactoryBot.define do
  factory :category do
    association :created_by, factory: :user
    name { Faker::Name.name }
  end
end

