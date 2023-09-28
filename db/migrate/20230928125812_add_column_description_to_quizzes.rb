# frozen_string_literal: true

class AddColumnDescriptionToQuizzes < ActiveRecord::Migration[7.0]
  def change
    add_column :quizzes, :description, :text
  end
end
