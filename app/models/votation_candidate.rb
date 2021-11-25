# == Schema Information
#
# Table name: votation_candidates
#
#  id                   :bigint           not null, primary key
#  votes                :bigint           default(0), not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  accounts_id          :bigint
#  spotify_playlists_id :bigint
#  spotify_songs_id     :bigint
#  votations_id         :bigint
#
# Indexes
#
#  index_votation_candidates_on_accounts_id           (accounts_id)
#  index_votation_candidates_on_spotify_playlists_id  (spotify_playlists_id)
#  index_votation_candidates_on_spotify_songs_id      (spotify_songs_id)
#  index_votation_candidates_on_votations_id          (votations_id)
#
# Foreign Keys
#
#  fk_rails_...  (accounts_id => accounts.id)
#  fk_rails_...  (spotify_playlists_id => spotify_playlists.id)
#  fk_rails_...  (spotify_songs_id => spotify_songs.id)
#  fk_rails_...  (votations_id => votations.id)
#
class VotationCandidate < ApplicationRecord
  belongs_to :account
  belongs_to :spotify_playlist
  belongs_to :spotify_song
  belongs_to :votation
end
