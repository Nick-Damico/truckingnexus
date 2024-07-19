class CreateDriverLogs < ActiveRecord::Migration[7.1]
  def change
    create_table :driver_logs do |t|
      t.datetime :started_at, null: false
      t.datetime :ended_at, null: false
      t.references :driver, null: false, foreign_key: { to_table: :users }
      t.string :first_name
      t.string :last_name
      t.integer :employee_number
      t.integer :total_miles
      t.integer :tractor_number
      t.integer :trailer_number_1
      t.integer :trailer_number_2

      t.timestamps
    end
  end
end
