class CreateVotations < ActiveRecord::Migration[6.1]
  def change
    create_table :votations do |t|
      t.boolean :in_progress
      t.boolean :queued

      t.timestamps
    end

    add_reference :votations, :ongoing_playlist, foreign_key: true
    add_reference :votations, :accounts, foreign_key: true
  end
end
