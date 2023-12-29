# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EmploymentHistory, type: :model do
  subject { create(:employment_history) }

  it { should belong_to(:employee) }
  it { should belong_to(:employer) }
  it { should have_db_index(%i[employee_id]).unique(true) }
end
