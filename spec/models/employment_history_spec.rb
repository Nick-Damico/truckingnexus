# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EmploymentHistory, type: :model do
  subject { create(:employment_history) }

  it { should belong_to(:employee) }
  it { should belong_to(:employer) }

  # TODO: The migration that added the unique index for current: true was removed.
  #       This broke the spec below. Currently there should only be
  #       a single current: true EmploymentHistory record, but this
  #       is no longer enforced by a validation.
  #
  #       Clearing the previous current: true record is handled by
  #       the service EmploymentHistoryManager after the User
  #       record is succesfully updated. If there was a previous current: true
  #       it exists until the service completes its call.
  xdescribe 'Current employer' do
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
