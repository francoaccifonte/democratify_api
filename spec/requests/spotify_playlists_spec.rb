require 'rails_helper'

RSpec.describe '/spotify_playlists' do
  let(:account) { create(:account) }

  context 'when user is logged in' do
    before { WithAccountCookies.set_account_cookie(cookies, account) }

    it 'returns http success' do
      get spotify_playlists_url
      expect(response).to have_http_status(:success)
    end
  end

  context 'when user is not logged in' do
    it 'redirects home' do
      get spotify_playlists_url
      expect(response).to redirect_to root_url
    end
  end
end
