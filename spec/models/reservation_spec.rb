require 'rails_helper'

RSpec.describe Reservation, type: :model do
  describe 'validations' do
    describe 'presence' do
      it { is_expected.to validate_presence_of(:time_table_id) }
      it { is_expected.to validate_presence_of(:date) }
      it { is_expected.to validate_presence_of(:planner_id) }
    end

    describe 'custom validate' do
      around do |e|
        travel_to('2021-05-28'){ e.run }
      end

      it 'is Saturday and invalid time table id' do
        travel +1.day

        reservation = FactoryBot.build(:reservation, date: Date.current.strftime, time_table_id: '1')
        reservation.valid?
        expect(reservation.errors[:time_table_id]).to include('土曜日は11時～15時までしか選択できません')
      end

      it 'Sunday' do
        travel +2.day

        reservation = FactoryBot.build(:reservation, date: Date.current.strftime)
        reservation.valid?
        expect(reservation.errors[:date]).to include('日曜日は働いちゃダメです！')
      end

      it 'today or past day' do
        reservation = FactoryBot.build(:reservation, date: Date.today.strftime)
        reservation.valid?
        expect(reservation.errors[:date]).to include('明日以降の日付を登録して下さい')
      end
    end
  end

  describe 'Association' do
    describe 'belongs_to' do
      it { is_expected.to belong_to(:planner) }
      it { is_expected.to belong_to(:customer).optional }
    end
  end

  describe 'scope' do
    let(:reservation_1){ create(:reservation) }
    let(:reservation_2){ create(:reservation, customer_id: nil) }
    let(:reservation_3){ create(:reservation, date: (Date.today - 1).strftime ) }

      describe 'after_today' do

      end
  end
end
