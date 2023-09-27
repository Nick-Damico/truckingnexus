# frozen_string_literal: true

class AddCorrectAnswerToQuestions < ActiveRecord::Migration[7.0]
  def change
    add_reference :questions, :correct_answer, foreign_key: { to_table: :answers }
  end
end
