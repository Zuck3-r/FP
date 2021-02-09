class Skill < ApplicationRecord
  has_many :planner_skills
  has_many :planners, through: :planner_skills

  validates :name, presence: true, length: { maximum: 15 }
end

