# frozen_string_literal: true

class AddIndexCurrentEmployeeIdToEmploymentHistories < ActiveRecord::Migration[7.0]
  def change
    add_index :employment_histories, %i[employee_id], unique: true, where: 'current IS true'
  end
end
