FactoryBot.define do
  factory :reservation do
    time_table_id { 1 }
    date { nil }
    planner_id { 1 }
    customer_id { 1 }
  end
end
