require 'rails_helper'

RSpec.describe PlannerSkill, type: :model do
  describe 'validations' do
    describe 'presence' do
      it { is_expected.to validate_presence_of(:planner_id) }
      it { is_expected.to validate_presence_of(:skill_id) }
    end

    describe 'uniqueness of record' do
      FactoryBot.create(:skill)
      FactoryBot.create(:planner)
      FactoryBot.create(:planner_skill)

      it 'is invalid with a duplicate record' do
        planner_skill = FactoryBot.build(:planner_skill)
        expect(planner_skill).to_not be_valid
      end
    end
  end
end
