require 'rails_helper'

describe SpotifyPlaylistSerializer do
  subject { described_class.new(**options).serialize_to_json(spotify_playlist) }

  let(:spotify_playlist) { create(:spotify_playlist) }
  let(:options) { {} }

  it 'contains the correct attributes' do
    [:id, :cover_art_url, :description, :name, :created_at, :updated_at, :account_id, :external_id, :spotify_user_id].each do |attribute|
      expect(subject).to include("\"#{attribute}\":")
      expect(subject).to include(spotify_playlist.attributes[attribute].to_s) if spotify_playlist.attributes[attribute]
    end
  end

  context 'when it has nested records' do
    let!(:spotify_song) { create(:spotify_song) }

    before { SpotifyPlaylistSong.create!(spotify_playlist:, spotify_song:) }

    it 'contains associated records' do
      expect(subject).to include("\"spotify_songs\":")
      expect(subject).to include(spotify_song.id.to_s)
    end
  end
end
