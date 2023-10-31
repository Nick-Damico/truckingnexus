# frozen_string_literal: true

class RemoveCompanyRefFromUsers < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :company_id, :bigint
  end
end
