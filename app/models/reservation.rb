class Reservation < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :planner
  belongs_to :customer, optional: true
  belongs_to :time_table

  validates :time_table_id, presence: true, inclusion: { in: 1..16 }
  validates :date, presence: true
  validates :planner_id, uniqueness: { scope: %i[time_table_id date], message: 'に同じ時間の予約枠が存在します' }, presence: true
  validates :customer_id, numericality: { only_integer: true }, allow_nil: true
  validate :not_sunday
  validate :not_before_today
  validate :saturday_time
  validate :till_next_year

  START_TIME_ID = 3
  END_TIME_ID = 10

  scope :after_today, -> { where('date >= ?', Date.current) }
  scope :filled_reservation, -> { where.not(customer_id: nil) }
  scope :empty_reservation, -> { where(customer_id: nil) }

  def past_day?
    date <= Date.current
  end

  private

  def saturday_time
    return unless date.present?
    return unless time_table_id.present?

    errors.add(:time_table_id, '土曜日は11時～15時までしか選択できません') if date.saturday? && [*START_TIME_ID..END_TIME_ID].exclude?(time_table_id)
  end

  def not_sunday
    return unless date.present?

    errors.add(:date, '日曜日は働いちゃダメです！') if date.sunday?
  end

  def not_before_today
    return unless date.present?

    errors.add(:date, '明日以降の日付を登録して下さい') if date <= Date.current
  end

  def till_next_year
    return unless date.present?

    errors.add(:date, '一年以内の日程しか作成できません') if date >= Date.current.next_year
  end
end

