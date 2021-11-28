class CreateVotationCandidates < ActiveRecord::Migration[6.1]
  def change
    create_table :votation_candidates do |t|
      t.bigint :votes, null: false, default: 0

      t.timestamps
    end

    add_reference :votation_candidates, :account, foreign_key: true
    add_reference :votation_candidates, :votation, foreign_key: true
    add_reference :votation_candidates, :spotify_playlist_song, foreign_key: true
    add_reference :votation_candidates, :ongoing_playlist, foreign_key: true
  end
end
