# frozen_string_literal: true

class EmploymentHistory < ApplicationRecord
  belongs_to :employee, class_name: 'User'
  belongs_to :company
end
