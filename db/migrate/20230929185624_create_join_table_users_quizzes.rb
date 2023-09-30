# frozen_string_literal: true

class CreateJoinTableUsersQuizzes < ActiveRecord::Migration[7.0]
  def change
    create_join_table :users, :quizzes do |t|
      t.integer :score, null: true
      t.index %i[user_id quiz_id]
      t.index %i[quiz_id user_id]
    end
  end
end
