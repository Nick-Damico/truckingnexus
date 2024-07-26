# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DateRange, type: :model do
  describe '#initialize' do
    it 'accepts a start and end date' do
      cur_time = Time.current
      start_date = cur_time.beginning_of_day
      end_date = cur_time.end_of_day

      date_range = DateRange.new(start_date:, end_date:)

      expect(date_range.start_date).to eq start_date
      expect(date_range.end_date).to eq end_date
    end
  end

  describe '#total_hours' do
    it 'returns the total number of hours within the date range' do
      cur_time = Time.current
      start_date = cur_time.beginning_of_day
      end_date = cur_time.end_of_day

      date_range = DateRange.new(start_date:, end_date:)

      expect(date_range.total_hours).to eq 24
    end
  end
end
