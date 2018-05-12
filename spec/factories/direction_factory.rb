FactoryBot.define do
  sequence :step do |n|
    n
  end
  sequence :action do |n|
    "#{Faker::Hacker.verb} #{n}"
  end
  factory :direction do
    association :recipe, factory: :recipe
    step
    action
  end
end