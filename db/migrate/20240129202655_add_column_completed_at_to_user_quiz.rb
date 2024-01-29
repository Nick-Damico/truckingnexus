# frozen_string_literal: true

class AddColumnCompletedAtToUserQuiz < ActiveRecord::Migration[7.1]
  def change
    add_column :user_quizzes, :completed_at, :datetime
  end
end
