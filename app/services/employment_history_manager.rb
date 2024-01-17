# frozen_string_literal: true

class EmploymentHistoryManager
  def initialize(employee:, employer:)
    raise ArgumentError, ':employee should be of type User' unless employee.is_a?(User)
    raise ArgumentError, ':employer should be of type Company' unless employer.is_a?(Company)

    @employee = employee
    @employer = employer
  end

  def call
    clear_previous_current_employer if current_employer?
  end

  private

  def clear_previous_current_employer
    @employee
      .employment_histories
      .where(current: true)
      .where.not(employer_id: @employer.id)
      .update_all(current: false)
  end

  def current_employer?
    @employee.employment_histories.where(current: true, employer_id: @employer.id).any?
  end
end
