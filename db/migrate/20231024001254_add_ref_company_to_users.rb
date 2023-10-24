# frozen_string_literal: true

class AddRefCompanyToUsers < ActiveRecord::Migration[7.0]
  def change
    add_reference :users, :company, null: true, foreign_key: true
  end
end
