# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DutyStatus, type: :model do
  let!(:driver_log) { create(:driver_log) }
  subject { driver_log.duty_statuses.build }

  describe 'validations' do
    it {
      is_expected.to define_enum_for(:activity).with_values({
                                                              off_duty: 'off_duty',
                                                              on_duty: 'on_duty',
                                                              driving: 'driving',
                                                              sleeper: 'sleeper'
                                                            }).backed_by_column_of_type(:enum)
    }
    it { should validate_presence_of(:activity).with_message('is not included in the list') }
    it { should validate_presence_of(:started_at) }
    it { should validate_presence_of(:ended_at) }

    it 'is expected that the started_at time is within the 24-hour range of the driver log' do
      new_duty_status = driver_log.duty_statuses.new(activity: :on_duty, started_at: 1.day.from_now,
                                                     ended_at: 1.hour.from_now)

      expect(new_duty_status).to be_invalid
      expect(new_duty_status.errors[:started_at]).to include('must be within 24-hour period of driver log')
    end

  end
end
