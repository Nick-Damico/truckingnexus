# frozen_string_literal: true

class DriverLog < ApplicationRecord
  belongs_to :driver, class_name: 'User'
  has_many :duty_statuses

  validates :started_at, :ended_at, presence: true
  validate :dates_within_24_hours

  after_initialize :set_start_and_end_times

  private

  def set_start_and_end_times
    cur_time = Time.current

    self.started_at = cur_time.beginning_of_day
    self.ended_at = cur_time.end_of_day
  end

  def dates_within_24_hours
    return unless started_at.present? && ended_at.present?

    log_date_range = DateRange.new(start_date: started_at, end_date: ended_at)
    return if log_date_range.total_hours == 24

    errors.add(:base, 'Start and End times must be within a 24-hour period')
  end
end
