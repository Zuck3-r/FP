class CreateReservations < ActiveRecord::Migration[6.1]
  def change
    create_table :reservations do |t|
      t.integer :time_table_id, null: false
      t.date :date, null: false
      t.references :planner, foreign_key: true, null: false
      t.references :customer, foreign_key: true
      t.timestamps

      t.index %i[planner_id time_table_id date], unique: true
    end
  end
end

