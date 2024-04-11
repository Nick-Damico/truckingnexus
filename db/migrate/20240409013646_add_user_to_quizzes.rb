class AddUserToQuizzes < ActiveRecord::Migration[7.1]
  def change
    reversible do |dir|
      dir.up do
        add_reference :quizzes, :author, foreign_key: { to_table: :users }

        admin = ::User.find_by(email: 'admin@truckingnexus.com')
        ::Quiz.where(author: nil).update_all(author_id: admin.id)

        change_column_null :quizzes, :author_id, false
      end

      dir.down do
        remove_reference :quizzes, :author, foreign_key: { to_table: :users }
      end
    end
  end
end
