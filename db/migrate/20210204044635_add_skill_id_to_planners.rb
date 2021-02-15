class AddSkillIdToPlanners < ActiveRecord::Migration[6.1]
  def change
    add_column :planners, :skill_id, :integer
  end
end

