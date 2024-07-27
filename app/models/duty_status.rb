# frozen_string_literal: true

class DutyStatus < ApplicationRecord
  belongs_to :driver_log

  enum :activity, {
    off_duty: 'off_duty',
    on_duty: 'on_duty',
    driving: 'driving',
    sleeper: 'sleeper'
  }, validate: true

  validates :started_at, :ended_at, presence: true
  validate :start_time_within_log_range

  private

  def start_time_within_log_range
    return if driver_log.date_range.include?(started_at)

    errors.add(:started_at, 'must be within 24-hour period of driver log')
  end
end
