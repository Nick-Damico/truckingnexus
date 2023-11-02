# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EmploymentHistory, type: :model do
  subject { create(:employment_history) }

  it { belong_to(:employee) }
  it { belong_to(:employer) }
end
