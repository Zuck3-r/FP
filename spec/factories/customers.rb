FactoryBot.define do
  factory :customer do
    name { 'Lil Uzi Vert' }
    sequence(:email) { |n| "liluzi#{n}@example.com" }
    password { 'pass1234' }
  end
end
