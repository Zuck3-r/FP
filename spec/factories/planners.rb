FactoryBot.define do
  factory :planner do
    name { 'Kamado Tanjero' }
    sequence(:email) { |n| "kamado#{n}@example.com" }
    password { 'pass1234' }
  end
end
