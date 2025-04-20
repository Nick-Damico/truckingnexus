# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EmploymentHistory, type: :model do
  subject { create(:employment_history) }

  it { should belong_to(:employee) }
  it { should belong_to(:employer) }
end
