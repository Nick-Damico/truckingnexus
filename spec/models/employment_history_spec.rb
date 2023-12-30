# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EmploymentHistory, type: :model do
  subject { create(:employment_history) }

  it { should belong_to(:employee) }
  it { should belong_to(:employer) }
  it { should have_db_index(%i[employee_id]).unique(true) }

  describe 'Current employer' do
    it 'should restrict a single current employer for an employee' do
      employee = create(:user)
      employer = create(:company)
      employee.employment_histories.create(employer:, current: true)
      expect(employee.current_employer).to eq employer

      new_current_employer = create(:company)
      employee.employment_histories.build(employer: new_current_employer, current: true)
      expect { employee.save! }.to raise_exception(ActiveRecord::RecordNotUnique)
    end
  end
end
