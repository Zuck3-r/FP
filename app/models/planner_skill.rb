class PlannerSkill < ApplicationRecord
  belongs_to :planner
  belongs_to :skill

  validates :planner_id, uniqueness: { scope: :skill_id }
  validates :skill_id, presence: true
end

