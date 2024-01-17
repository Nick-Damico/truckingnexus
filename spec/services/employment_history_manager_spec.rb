# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EmploymentHistoryManager do
  let(:user) { create(:user, :with_current_employer) }

  it 'raises an error if Employee is not of type User' do
    company = create(:company)
    invalid_employee = create(:company)
    expect do
      EmploymentHistoryManager.new(employee: invalid_employee, employer: company)
    end.to raise_error(ArgumentError)
  end

  it 'raises an error if Employer is not of type Company' do
    employee = create(:user)
    invalid_employer = create(:user)
    expect do
      EmploymentHistoryManager.new(employee:, employer: invalid_employer)
    end.to raise_error(ArgumentError)
  end

  describe '#call' do
    context 'working with current employer record' do
      it 'removes the current attribute from previous EmploymentHistory records' do
        new_cur_employer = create(:company)
        user.employment_histories.create!(employer: new_cur_employer, current: true)

        expect do
          EmploymentHistoryManager.new(
            employee: user,
            employer: new_cur_employer
          ).call
        end.to_not raise_error
        expect(user.employment_histories.where(current: true).count).to eq 1
        expect(user.employment_histories.current_employer.employer).to eq new_cur_employer
      end
    end
  end
end
