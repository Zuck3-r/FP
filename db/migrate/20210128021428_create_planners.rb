class CreatePlanners < ActiveRecord::Migration[6.1]
  def change
    create_table :planners do |t|
      t.string :name, null: false, limit: 40
      t.string :email, null: false, unique: true
      t.string :password_digest, null: false

      t.index :email, unique: true
      t.timestamps
    end
  end
end
