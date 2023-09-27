class CreateQuizzes < ActiveRecord::Migration[7.0]
  def change
    create_table :quizzes do |t|
      t.string :name, null: true

      t.timestamps
    end

    add_index :quizzes, :name, unique: true
  end
end
