class CreatePlannerSkills < ActiveRecord::Migration[6.1]
  def change
    create_table :planner_skills do |t|
      t.integer :planner_id,  null: false
      t.integer :skill_id,    null: false
      t.timestamps

      t.index %i[planner_id skill_id], unique: true
    end
  end
end

