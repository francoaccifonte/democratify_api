# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::OngoingPlaylistsController do
  describe 'PUT /ongoing_playlists' do
    subject { put(api_ongoing_playlist_path(ongoing_playlist.id), params:, headers: auth_headers) }

    before { mock_user(mock) }

    include_context 'with mocked spotify client'
    let!(:mock) { mocked_client }
    let!(:account) { create(:account) }
    let!(:user) { create(:spotify_user, account:) }
    let!(:playlist) { create(:spotify_playlist, account:, spotify_user: user) }
    let!(:songs) { create_list(:spotify_playlist_song, 10, spotify_playlist: playlist) }
    let!(:ongoing_playlist) do
      create(:ongoing_playlist,
             account:,
             spotify_playlist: playlist)
    end
    let(:auth_headers) { { Authorization: "Bearer #{account.token}" } }

    shared_examples_for 'returns no content' do
      it 'has status code no content' do
        subject
        expect(response).to have_http_status(:no_content)
      end
    end

    context 'when updating the pool size,' do
      let(:params) { { pool_size: ongoing_playlist.pool_size + 1 } }

      it_behaves_like 'returns no content'

      it 'updates the pool size' do
        expect { subject }.to change { ongoing_playlist.reload.pool_size }.by(1)
      end
    end

    context 'when reordering the playlist,' do
      let(:params) { { spotify_playlist_songs: ongoing_playlist.spotify_playlist_songs.pluck(:id).shuffle } }

      it_behaves_like 'returns no content'

      it 'reorders the songs' do
        old_order = ongoing_playlist.spotify_playlist_songs.sort_by(&:id).pluck(:id, :index)
        subject
        new_order = ongoing_playlist.reload.spotify_playlist_songs.sort_by(&:id).pluck(:id, :index)
        expect(old_order).not_to eq(new_order)
      end

      context 'when params are invalid' do
        let(:params) { { spotify_playlist_songs: [1, 2, 3] } }

        it 'returns an unprocessable entity' do
          subject
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end
  end
end
