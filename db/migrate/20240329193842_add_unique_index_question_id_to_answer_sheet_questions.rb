class AddUniqueIndexQuestionIdToAnswerSheetQuestions < ActiveRecord::Migration[7.1]
  def change
    add_index :answer_sheet_questions, [:id, :question_id], unique: true
  end
end
