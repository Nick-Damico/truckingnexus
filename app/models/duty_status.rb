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
  validate :times_within_log_range

  private

  def times_within_log_range
    validate_time_within_range(:started_at)
    validate_time_within_range(:ended_at)
  end

  def validate_time_within_range(attr)
    return if send(attr).nil?
    return if driver_log.date_range.include?(send(attr))

    errors.add(attr, 'must be within 24-hour period of driver log')
  end
end
