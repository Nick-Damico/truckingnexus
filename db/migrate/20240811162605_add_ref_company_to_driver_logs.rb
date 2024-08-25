class AddRefCompanyToDriverLogs < ActiveRecord::Migration[7.1]
  def change
    add_reference :driver_logs, :company, null: false, foreign_key: true
  end
end
