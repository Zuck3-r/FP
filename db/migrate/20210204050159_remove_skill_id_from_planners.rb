class RemoveSkillIdFromPlanners < ActiveRecord::Migration[6.1]
  def change
    remove_column :planners, :skill_id, :integer
  end
end
