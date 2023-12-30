# frozen_string_literal: true

class EmploymentHistoryManager
  def initialize(employee:, employer:)
    raise ArgumentError, ':employee should be of type User' unless employee.is_a?(User)
    raise ArgumentError, ':employer should be of type Company' unless employer.is_a?(Company)

    @employee = employee
    @employer = employer
  end

  def set_current_employer; end
end
