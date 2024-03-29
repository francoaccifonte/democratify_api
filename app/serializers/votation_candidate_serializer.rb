# frozen_string_literal: true

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
class VotationCandidateSerializer < Panko::Serializer
  attributes :id, :votes, :created_at, :updated_at,
             :account_id, :ongoing_playlist_id, :spotify_playlist_song_id, :votation_id

  has_one :spotify_song, serializer: SpotifySongSerializer, only: %i[id album artist cover_art title]

  delegate :spotify_song, to: :object
end
