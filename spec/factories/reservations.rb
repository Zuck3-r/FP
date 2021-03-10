FactoryBot.define do
  factory :reservation do
    time_table_id { 1 }
    date { nil }
    planner { FactoryBot.create(:planner) }
    customer { FactoryBot.create(:customer) }
  end
end
