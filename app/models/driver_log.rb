# frozen_string_literal: true

class DriverLog < ApplicationRecord
  belongs_to :driver, class_name: 'User'
  has_many :duty_statuses

  after_initialize :set_start_and_end_times

  validates :started_at, :ended_at, presence: true

  private

  def set_start_and_end_times
    cur_time = Time.current

    self.started_at = cur_time.beginning_of_day
    self.ended_at = cur_time.end_of_day
  end
end
