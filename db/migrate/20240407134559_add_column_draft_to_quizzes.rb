class AddColumnDraftToQuizzes < ActiveRecord::Migration[7.1]
  def change
    add_column :quizzes, :draft, :boolean, default: true
    add_index :quizzes, :draft
  end
end
