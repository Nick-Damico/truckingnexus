class CreateAnswerSheetQuestions < ActiveRecord::Migration[7.0]
  def change
    create_table :answer_sheet_questions do |t|
      t.references :question, null: false, foreign_key: true
      t.references :answer, null: true, foreign_key: true
      t.references :answer_sheet, null: false, foreign_key: true

      t.timestamps
    end
  end
end
