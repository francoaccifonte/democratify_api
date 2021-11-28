class CreateVotations < ActiveRecord::Migration[6.1]
  def change
    create_table :votations do |t|
      t.boolean :in_progress, null: false
      t.boolean :queued, null: false

      t.datetime :scheduled_start_for, null: false
      t.datetime :scheduled_start_at, null: false
      t.datetime :scheduled_end_for, null: false
      t.datetime :scheduled_end_at, null: false
      t.datetime :scheduled_close_for, null: false

      t.datetime :started_at

      t.timestamps
    end

    add_reference :votations, :ongoing_playlist, foreign_key: true, null: false
    add_reference :votations, :account, foreign_key: true, null: false
    add_index :votations, %i[account_id ongoing_playlist_id], unique: false
  end
end
