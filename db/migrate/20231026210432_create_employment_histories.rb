# frozen_string_literal: true

class CreateEmploymentHistories < ActiveRecord::Migration[7.0]
  def change
    create_table :employment_histories do |t|
      t.references :user, null: false, foreign_key: true
      t.references :company, null: false, foreign_key: true
      t.boolean :current

      t.timestamps
    end
  end
end
