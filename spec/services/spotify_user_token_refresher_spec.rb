require 'rails_helper'

describe SpotifyUserTokenRefresher do
  subject { described_class.call(user:) }

  context 'when token is expired' do
    let!(:user) { create(:spotify_user, access_token_expires_at: 3.days.ago) }

    before do
      stub_request(:post, "https://accounts.spotify.com/api/token")
        .to_return(status: response_code, body: response_body)
    end

    context 'and response is successful' do
      let!(:response_code) { 200 }
      let!(:response_body) do
        JSON.unparse(
          {
            access_token: "new_token",
            token_type: "Bearer",
            expires_in: 3600,
            scope: "some_scope"
          }
        )
      end

      it 'refreshes it' do
        expect { subject }.to(change { user.reload.access_token_expires_at })
        expect(user.access_token).to eq('new_token')
      end
    end

    context 'and response is an error' do
      let!(:response_code) { 422 }
      let!(:response_body) do
        JSON.unparse({ error: 'some error description' })
      end

      it 'throws an error' do
        old_token = user.access_token
        expect { subject }.to raise_error(Spotify::Errors::SpotifyError)
        expect(user.reload.access_token).to eq(old_token)
      end
    end
  end

  context 'when token is still valid' do
    let!(:user) { create(:spotify_user, access_token_expires_at: 3.days.from_now) }

    it 'does nothing' do
      allow(Spotify::Client).to receive(:new).and_call_original
      expect { subject }.not_to(change { user.reload.access_token })
      expect(Spotify::Client).not_to have_received(:new)
    end
  end
end
