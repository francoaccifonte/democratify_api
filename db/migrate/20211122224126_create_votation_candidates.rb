class CreateVotationCandidates < ActiveRecord::Migration[6.1]
  def change
    create_table :votation_candidates do |t|

      t.timestamps
    end

    add_reference :votation_candidates, :accounts, foreign_key: true
    add_reference :votation_candidates, :votations, foreign_key: true
    add_reference :votation_candidates, :spotify_songs, foreign_key: true
    add_reference :votation_candidates, :spotify_playlists, foreign_key: true
  end
end
