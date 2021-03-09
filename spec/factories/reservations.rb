FactoryBot.define do
  factory :reservation do
    time_table_id { 1 }
    date { (Date.today + 1).strftime }
    planner_id { 1 }
    customer_id { 1 }
  end
end
