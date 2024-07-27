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
  end
end
