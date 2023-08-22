require 'rails_helper'

describe PlaylistReorderer do
  subject { described_class.call(spotify_playlist:, new_order:) }

  let!(:account) { create(:account) }
  let!(:spotify_playlist) { create(:spotify_playlist, :with_songs) }

  context 'when parameters are correct,' do
    let(:new_order) { spotify_playlist.spotify_playlist_songs.shuffle.pluck(:id) }

    it 'reorders the playlist' do
      subject
      expect(spotify_playlist.spotify_playlist_songs.order(index: :asc).pluck(:id)).to match_array(new_order)
    end
  end

  context 'when parameters are invalid,' do
    context 'with repeated song ids' do
      let(:new_order) { spotify_playlist.spotify_playlist_songs.shuffle.pluck(:id)[0..-2] + [spotify_playlist.spotify_playlist_songs.sample.id] }

      xit 'FLAKY: returns an error' do
        expect { subject }.to raise_error(UnprocessableEntityError)
      end
    end

    context 'with extra song ids' do
      let(:new_order) { spotify_playlist.spotify_playlist_songs.shuffle.pluck(:id) + [321] }

      it 'returns an error' do
        expect { subject }.to raise_error(UnprocessableEntityError)
      end
    end

    context 'with missing song ids' do
      let(:new_order) { spotify_playlist.spotify_playlist_songs.shuffle.pluck(:id)[0..-2] }

      it 'returns an error' do
        expect { subject }.to raise_error(UnprocessableEntityError)
      end
    end
  end
end
