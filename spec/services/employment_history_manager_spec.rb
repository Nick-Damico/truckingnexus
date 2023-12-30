# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EmploymentHistoryManager do
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
end
