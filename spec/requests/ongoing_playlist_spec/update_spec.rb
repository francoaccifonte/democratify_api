# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'OngoingPlaylists', type: :request do
  describe 'PUT /ongoing_playlists' do
    include_context 'with mocked spotify client'
    let!(:mock) { mocked_client }
    before { mock_user(mock) }

    let!(:account) { create(:account) }
    let!(:user) { create(:spotify_user, account: account) }

    let!(:playlist) { create(:spotify_playlist, account: account, spotify_user: user) }
    let!(:songs) { create_list(:spotify_playlist_song, 10, spotify_playlist: playlist) }
    let!(:ongoing_playlist) do
      create(:ongoing_playlist,
             account: account,
             spotify_playlist: playlist)
    end

    let(:auth_headers) { { Authorization: "Bearer #{account.token}" } }

    subject { put(ongoing_playlist_path(ongoing_playlist.id), params: params, headers: auth_headers) }

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
      let(:params) do
        {
          spotify_playlist_songs:
          ongoing_playlist.spotify_playlist_songs.pluck(:id).shuffle.each_with_index.map do |id, index|
            { id:, index: }
          end
        }
      end

      it_behaves_like 'returns no content'

      it 'reorders the songs' do
        old_order = ongoing_playlist.spotify_playlist_songs.sort_by(&:id).pluck(:id, :index)
        subject
        new_order = ongoing_playlist.reload.spotify_playlist_songs.sort_by(&:id).pluck(:id, :index)
        expect(old_order).not_to eq(new_order)
      end
    end
  end
end
