# frozen_string_literal: true

class EmploymentHistory < ApplicationRecord
  belongs_to :employee, class_name: "User", foreign_key: :employee_id
  belongs_to :employer, class_name: "Company", foreign_key: :employer_id

  scope :current_employer, -> { find_by(current: true) }
  #       The migration that added the unique index for `current: true` was removed.
  #       Currently there should only be a single `current: true`
  #       EmploymentHistory record, but this is no longer enforced by a validation.
  #
  #       Clearing the previous current: true record is handled by
  #       the service EmploymentHistoryManager after the User
  #       record is succesfully updated. If there was a previous current: true
  #       it exists until the service completes its call.
end
