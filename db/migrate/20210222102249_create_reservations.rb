class CreateReservations < ActiveRecord::Migration[6.1]
  def change
    create_table :reservations do |t|
      t.integer :time_table_id, null: false
      t.date :date, null: false
      t.integer :planner_id, null: false
      t.integer :customer_id

      t.timestamps
    end
  end
end

