require 'rails_helper'

RSpec.describe PlaylistImportWorker, type: :worker do
  subject { described_class.new.perform(spotify_user.id) }

  let!(:account) { create(:account) }
  let!(:spotify_user) { create(:spotify_user, account:) }

  context 'happy path' do
    let(:successful_body) do
      {
        items: [
          id: 123,
          name: 'Song1',
          description: 'fake song 1'
        ]
      }
    end

    before do
      stub_request(:get, "https://api.spotify.com/v1/me/playlists").to_return(status: 200, body: successful_body.to_json)

      successful_body.fetch(:items).each do |playlist|
        image_body = [{
          url: "https://cdn.fakeSpotify.com/images/#{playlist.fetch(:id)}"
        }]
        stub_request(:get, "https://api.spotify.com/v1/playlists/#{playlist.fetch(:id)}/images").to_return(status: 200, body: image_body.to_json)
      end
    end

    it 'creates a playlist' do
      expect { subject }.to change(SpotifyPlaylist, :count).by(1)
    end

    it 'enqueues another worker' do
      subject
      expect(ImportSpotifySongsIntoPlaylistWorker.jobs.count).to eq(1)
    end

    it 'is idempotent' do
      expect { described_class.new.perform(spotify_user.id) }.to change(SpotifyPlaylist, :count).by(1)
      expect { described_class.new.perform(spotify_user.id) }.not_to change(SpotifyPlaylist, :count)
      playlist = SpotifyPlaylist.last
      old_time = playlist.updated_at
      described_class.new.perform(spotify_user.id)
      expect(old_time).not_to eq(playlist.reload.updated_at)
    end
  end
end
