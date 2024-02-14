# frozen_string_literal: true

class CreateReviews < ActiveRecord::Migration[7.1]
  def change
    create_table :reviews do |t|
      t.references :reviewer, null: false, foreign_key: { to_table: :users }
      t.integer :rating
      t.text :content
      t.string :title
      t.references :reviewable, polymorphic: true, null: false
      t.index %i[reviewable_type reviewer_id], unique: true, name: 'by_reviewer'

      t.timestamps
    end
  end
end
