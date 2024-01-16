class RemoveUniqueCurrentTrueIndexFromEmploymentHistories < ActiveRecord::Migration[7.1]
  def change
    remove_index :employment_histories, name: 'index_employment_histories_on_employee_id'
  end
end
