class Skill < ApplicationRecord
  belongs_to :planner

  validates :name, presence: true, length: { maximum: 15 }
end
