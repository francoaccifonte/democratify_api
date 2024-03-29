# == Schema Information
#
# Table name: ongoing_playlists
#
#  id                  :bigint           not null, primary key
#  pool_size           :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  account_id          :bigint           not null
#  playing_song_id     :bigint           not null
#  spotify_playlist_id :bigint           not null
#
# Indexes
#
#  index_ongoing_playlists_on_account_id                          (account_id)
#  index_ongoing_playlists_on_account_id_and_spotify_playlist_id  (account_id,spotify_playlist_id) UNIQUE
#  index_ongoing_playlists_on_playing_song_id                     (playing_song_id)
#  index_ongoing_playlists_on_spotify_playlist_id                 (spotify_playlist_id)
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#  fk_rails_...  (playing_song_id => spotify_playlist_songs.id)
#  fk_rails_...  (spotify_playlist_id => spotify_playlists.id)
#
require 'rails_helper'

RSpec.describe OngoingPlaylist do
  let!(:account) { create(:account) }
  let!(:user) { create(:spotify_user, account:) }

  let!(:songs) { create_list(:spotify_playlist_song, 10, spotify_playlist:) }
  let!(:spotify_playlist) { create(:spotify_playlist, account:, spotify_user: user) }

  context 'when all is correct,' do
    subject { create(:ongoing_playlist, account:, spotify_playlist:) }

    include_context 'with mocked spotify client'

    before do
      mock_user
    end

    it 'is valid' do
      expect(subject).to be_valid
    end
  end
end
