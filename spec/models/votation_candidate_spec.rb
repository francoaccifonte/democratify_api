# == Schema Information
#
# Table name: votation_candidates
#
#  id                       :bigint           not null, primary key
#  votes                    :bigint           default(0), not null
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  account_id               :bigint
#  ongoing_playlist_id      :bigint
#  spotify_playlist_song_id :bigint
#  votation_id              :bigint
#
# Indexes
#
#  index_votation_candidates_on_account_id                (account_id)
#  index_votation_candidates_on_ongoing_playlist_id       (ongoing_playlist_id)
#  index_votation_candidates_on_spotify_playlist_song_id  (spotify_playlist_song_id)
#  index_votation_candidates_on_votation_id               (votation_id)
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#  fk_rails_...  (ongoing_playlist_id => ongoing_playlists.id)
#  fk_rails_...  (spotify_playlist_song_id => spotify_playlist_songs.id)
#  fk_rails_...  (votation_id => votations.id)
#
require 'rails_helper'

RSpec.describe VotationCandidate do
  let!(:account) { create(:account) }
  let!(:spotify_playlist) { create(:spotify_playlist, :with_songs, account:) }
  let!(:ongoing_playlist) { create(:ongoing_playlist, :with_votation, account:, spotify_playlist:, pool_size: 2) }

  let!(:votation_candidate) do
    create(
      :votation_candidate,
      account:,
      ongoing_playlist:,
      spotify_playlist_song: ongoing_playlist.playing_song,
      votation: ongoing_playlist.votations.in_progress.first
    )
  end
  let!(:other_votation_candidate) do
    create(
      :votation_candidate,
      account:,
      ongoing_playlist:,
      spotify_playlist_song: ongoing_playlist.playing_song,
      votation: ongoing_playlist.votations.in_progress.first
    )
  end

  describe '#vote!' do
    it 'increases votes by one' do
      expect { votation_candidate.vote! }.to change(votation_candidate, :votes).by(1)
    end

    it 'does not change votes in other record' do
      expect { votation_candidate.vote! }.not_to change(other_votation_candidate, :votes)
    end
  end
end
