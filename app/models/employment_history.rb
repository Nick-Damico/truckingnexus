# frozen_string_literal: true

class EmploymentHistory < ApplicationRecord
  belongs_to :employee, class_name: 'User', foreign_key: :employee_id
  belongs_to :employer, class_name: 'Company', foreign_key: :employer_id
end
