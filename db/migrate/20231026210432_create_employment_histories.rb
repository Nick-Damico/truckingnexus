# frozen_string_literal: true

class CreateEmploymentHistories < ActiveRecord::Migration[7.0]
  def change
    create_table :employment_histories do |t|
      t.references :employee, null: false, foreign_key: { to_table: :users, column: :employee_id }
      t.references :employer, null: false, foreign_key: { to_table: :companies, column: :company_id }
      t.boolean :current

      t.timestamps
    end
  end
end
