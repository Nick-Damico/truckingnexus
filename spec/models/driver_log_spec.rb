# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DriverLog, type: :model do
  subject { build(:driver_log) }

  it { should belong_to(:driver) }
  it { should have_many(:duty_statuses) }

  describe 'validations' do
    it { should validate_presence_of(:started_at) }
    it { should validate_presence_of(:ended_at) }

    describe '#start_and_end_times' do
      context 'start and end times represent a 24-hour peroid' do
        it 'does not set an error if times are valid' do
          driver_log = build(:driver_log)
          driver_log.started_at = Time.current.beginning_of_day
          driver_log.ended_at = Time.current.end_of_day

          expect(driver_log).to be_valid
          expect(driver_log.errors[:base]).to_not include('Start and End times must be within a 24-hour period')
        end

        it 'sets errors if times are invalid' do
          driver_log = build(:driver_log)
          driver_log.started_at = Time.current.beginning_of_day
          driver_log.ended_at = 1.day.from_now.end_of_day

          expect(driver_log).to be_invalid
          expect(driver_log.errors[:base]).to include('Start and End times must be within a 24-hour period')
        end
      end
    end
  end

  describe 'after_initialize' do
    it 'sets started_at to the beginning of the day' do
      driver_log = build(:driver_log)
      expect(driver_log.started_at.to_s).to eq(Time.current.beginning_of_day.to_s)
    end

    it 'sets ended_at to the end of the day' do
      driver_log = build(:driver_log)
      expect(driver_log.ended_at.to_s).to eq Time.current.end_of_day.to_s
    end
  end
end
