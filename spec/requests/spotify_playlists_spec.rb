require 'rails_helper'

RSpec.describe '/spotify_playlists' do
  let(:account) { create(:account) }

  describe '#index' do
    context 'when user is logged in' do
      before { WithAccountCookies.set_account_cookie(cookies, account) }

      context 'with existing spotify_playlists' do
        let!(:spotify_playlists) { create(:spotify_playlist, account:) }

        it 'returns http success' do
          get spotify_playlists_url
          expect(response).to have_http_status(:success)
        end

        it 'assigns the correct component props' do
          get spotify_playlists_url
          expect(controller.instance_variable_get(:@component_props)).to include(
            {
              account: anything,
              playlists: anything
            }
          )
        end
      end

      context 'without existing spotify_playlists' do
        it 'returns http success' do
          get spotify_playlists_url
          expect(response).to have_http_status(:success)
        end
      end

      context 'with invalid cookies' do
        it 'redirects to login and clears cookies' do
          account.update!(token: 'fakeToken')
          get spotify_playlists_url
          expect(response).to redirect_to(root_url)
          expect(response.cookies[:account_id]).to be_nil
          expect(response.cookies[:token]).to be_nil
        end
      end
    end

    context 'when user is not logged in' do
      it 'redirects home' do
        get spotify_playlists_url
        expect(response).to redirect_to root_url
      end
    end
  end

  describe '#show' do
    context 'when user is logged in' do
      before { WithAccountCookies.set_account_cookie(cookies, account) }

      context 'with existing spotify_playlists' do
        let!(:spotify_playlist) { create(:spotify_playlist, account:) }

        it 'returns http success' do
          get spotify_playlist_url(spotify_playlist.id)
          expect(response).to have_http_status(:success)
        end

        it 'assigns the correct component props' do
          get spotify_playlist_url(spotify_playlist.id)
          expect(controller.instance_variable_get(:@component_props)).to include(
            {
              account: anything,
              playlist: anything
            }
          )
        end
      end
    end
  end
end
