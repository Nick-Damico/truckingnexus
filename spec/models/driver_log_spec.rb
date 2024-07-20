# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DriverLog, type: :model do
  subject { build(:driver_log) }

  it { should belong_to(:driver) }
  it { should have_many(:duty_statuses) }
end
