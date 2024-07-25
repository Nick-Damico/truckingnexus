# frozen_string_literal: true

class DriverLog < ApplicationRecord
  belongs_to :driver, class_name: 'User'
  has_many :duty_statuses

  validates :started_at, :ended_at, presence: true
  validate :start_and_end_dates

  after_initialize :set_start_and_end_times

  private

  def set_start_and_end_times
    cur_time = Time.current

    self.started_at = cur_time.beginning_of_day
    self.ended_at = cur_time.end_of_day
  end

  def start_and_end_dates
    return unless started_at.present? && ended_at.present?
    return if ((ended_at - started_at) / 1.hour.to_i).ceil == 24

    errors.add(:base, 'Start and End times must be within a 24-hour period')
  end
end
