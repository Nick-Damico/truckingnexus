class CreateCompanies < ActiveRecord::Migration[7.0]
  def change
    create_table :companies do |t|
      t.string :name, null: false
      t.string :state
      t.string :city

      t.timestamps
    end

    add_index :companies, :name, unique: true
  end
end
