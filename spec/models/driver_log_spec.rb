# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DriverLog, type: :model do
  subject { build(:driver_log) }

  it { should belong_to(:driver) }
  it { should have_many(:duty_statuses) }

  describe 'after_initialize' do
    it 'sets started_at to the beginning of the day' do
      driver_log = build(:driver_log)
      expect(driver_log.started_at.to_s).to eq(Time.zone.now.beginning_of_day.to_s)
    end

    it 'sets ended_at to the end of the day' do
      driver_log = build(:driver_log)
      expect(driver_log.ended_at.to_s).to eq Time.zone.now.end_of_day.to_s
    end
  end
end
