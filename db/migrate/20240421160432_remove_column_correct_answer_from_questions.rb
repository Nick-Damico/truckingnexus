class RemoveColumnCorrectAnswerFromQuestions < ActiveRecord::Migration[7.1]
  class ::Question < ApplicationRecord
    belongs_to :correct_answer, class_name: 'Answer', foreign_key: 'correct_answer_id', optional: true
  end
  class ::Answer < ApplicationRecord
    belongs_to :question
  end

  def change
    reversible do |dir|
      dir.up do
        add_column :answers, :correct, :boolean, default: false
        add_index :answers, :correct

        ::Question.all.each do |question|
          correct_answer = question.correct_answer

          correct_answer.update_column(:correct, true)
        end

        remove_column :questions, :correct_answer_id
      end

      dir.down do |dir|
        add_reference :questions, :correct_answer, foreign_key: { to_table: :answers }

        ::Question.all.each do |question|
          correct_answer = question.answers.find(&:correct)

          question.update_column(:correct_answer_id, correct_answer.id)
        end

        remove_column :answers, :correct
      end
    end
  end
end
