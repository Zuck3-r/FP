class CreateCustomers < ActiveRecord::Migration[6.1]
  def change
    create_table :customers do |t|
      t.string :name, null: false, limit: 40
      t.string :email, null: false
      t.string :password_digest, null: false

      t.index :email, unique: true
      t.timestamps
    end
  end
end

