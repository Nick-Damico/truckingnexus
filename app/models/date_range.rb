# frozen_string_literal: true

class DateRange
  attr_reader :start_date, :end_date

  def initialize(start_date:, end_date:)
    @start_date = start_date
    @end_date = end_date
  end

  def include?(time)
    (start_date..end_date).cover?(time)
  end

  def total_hours
    (end_date - start_date).ceil / 1.hour
  end
end
