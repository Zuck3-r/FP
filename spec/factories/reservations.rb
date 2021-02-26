FactoryBot.define do
  factory :reservation do
    time_table_id { 1 }
    date { "2021-02-27" }
    planner_id { 1 }
    customer_id { 1 }
  end
end
