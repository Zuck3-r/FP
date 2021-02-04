require 'rails_helper'

RSpec.describe Skill, type: :model do
  describe 'validations' do
    describe 'presence' do
      it { is_expected.to validate_presence_of(:name) }
    end
  end
end
