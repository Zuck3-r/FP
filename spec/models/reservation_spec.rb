require 'rails_helper'

RSpec.describe Reservation, type: :model do
  describe 'validations' do
    describe 'presence' do
      it { is_expected.to validate_presence_of(:time_table_id) }
      it { is_expected.to validate_presence_of(:date) }
      it { is_expected.to validate_presence_of(:planner_id) }
    end
  end

  describe 'Association' do
    describe 'belongs_to' do
      it { is_expected.to belong_to(:planner) }
      it { is_expected.to belong_to(:customer).optional }
    end
  end
end
