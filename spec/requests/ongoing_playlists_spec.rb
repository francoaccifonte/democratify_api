require 'rails_helper'

RSpec.describe "/ongoing_playlists" do
  let!(:account) { create(:account) }
  let!(:spotify_playlist) { create(:spotify_playlist, :with_songs, account:) }

  before { WithAccountCookies.set_account_cookie(cookies, account) }

  describe 'GET /ongoing_playlist' do
    subject { get ongoing_playlists_path }

    context 'when there is an ongoing playlist' do
      let!(:ongoing_playlist) { create(:ongoing_playlist, :with_votation, account:, spotify_playlist:) }

      it 'is successful' do
        subject
        expect(response).to have_http_status(:success)
      end
    end

    context 'when there is no ongoing playlist' do
      it 'redirects to /spotify_playlists' do
        subject
        expect(response).to redirect_to(spotify_playlists_url)
      end
    end
  end
end
