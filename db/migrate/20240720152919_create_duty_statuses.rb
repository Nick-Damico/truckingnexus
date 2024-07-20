class CreateDutyStatuses < ActiveRecord::Migration[7.1]
  def change

    reversible do |dir|
      dir.up do
        create_enum :activity_type, %w[on_duty driving off_duty sleeper]
      end

      dir.down do
        execute <<-SQL
          DROP TYPE activity_type;
        SQL
      end
    end

    create_table :duty_statuses do |t|
      t.references :driver_log, null: false, foreign_key: true
      t.enum :activity, enum_type: :activity_type, null: false

      t.datetime :started_at, null: false
      t.datetime :ended_at, null: false

      t.timestamps
    end
  end
end
