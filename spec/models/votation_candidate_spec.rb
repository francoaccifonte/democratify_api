# == Schema Information
#
# Table name: votation_candidates
#
#  id                        :bigint           not null, primary key
#  votes                     :bigint           default(0), not null
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  accounts_id               :bigint
#  ongoing_playlist_id       :bigint
#  spotify_playlist_songs_id :bigint
#  votation_id               :bigint
#
# Indexes
#
#  index_votation_candidates_on_accounts_id                (accounts_id)
#  index_votation_candidates_on_ongoing_playlist_id        (ongoing_playlist_id)
#  index_votation_candidates_on_spotify_playlist_songs_id  (spotify_playlist_songs_id)
#  index_votation_candidates_on_votation_id                (votation_id)
#
# Foreign Keys
#
#  fk_rails_...  (accounts_id => accounts.id)
#  fk_rails_...  (ongoing_playlist_id => ongoing_playlists.id)
#  fk_rails_...  (spotify_playlist_songs_id => spotify_playlist_songs.id)
#  fk_rails_...  (votation_id => votations.id)
#
require 'rails_helper'

RSpec.describe VotationCandidate, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
