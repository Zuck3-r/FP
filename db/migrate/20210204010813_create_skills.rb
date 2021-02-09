class CreateSkills < ActiveRecord::Migration[6.1]
  def change
    create_table :skills do |t|
      t.string :name, null: false, limit: 15

      t.timestamps
    end
  end
end

