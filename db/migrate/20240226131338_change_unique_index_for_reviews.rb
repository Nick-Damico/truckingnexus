class ChangeUniqueIndexForReviews < ActiveRecord::Migration[7.1]
  def change
    reversible do |dir|
      dir.up do
        remove_index :reviews, name: :by_reviewer
        add_index :reviews, [:reviewer_id, :reviewable_id, :reviewable_type], name: :by_reviewer
      end
      dir.down do
        remove_index :reviews, name: :by_reviewer
        add_index :reviews, [:reviewable_id, :reviewable_type], name: :by_reviewer
      end
    end
  end
end
