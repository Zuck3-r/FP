require 'rails_helper'

RSpec.describe Reservation, type: :model do
  describe 'validations' do
    describe 'presence' do
      it { is_expected.to validate_presence_of(:time_table_id) }
      it { is_expected.to validate_presence_of(:date) }
      it { is_expected.to validate_presence_of(:planner_id) }
    end
  end
end
