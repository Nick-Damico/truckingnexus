class CreateNotes < ActiveRecord::Migration[7.2]
  def change
    create_table :notes do |t|
      t.references :user, null: false, foreign_key: true, index: true
      t.references :geolocation, null: false, foreign_key: true, index: true
      t.text :body

      t.timestamps
    end
  end
end
