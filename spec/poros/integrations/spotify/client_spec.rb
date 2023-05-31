require 'rails_helper'

describe Spotify::Client do
  describe '.from_user' do
    subject { described_class.from_user(user) }

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

    before do
      stub_request(:post, "https://accounts.spotify.com/api/token")
        .to_return(status: response_code, body: response_body)
    end

    context 'when token is expired' do
      let!(:user) { create(:spotify_user, access_token: 'initial_token', access_token_expires_at: 3.days.ago) }

      it 'refreshes the token' do
        expect { subject }.to change { user.reload.access_token }.from('initial_token').to('new_token')
      end

      it 'returns a client object with the new credentials' do
        client = subject
        expect(client.access_token).to eq(user.reload.access_token)
        expect(client.refresh_token).to eq(user.reload.refresh_token)
      end
    end

    context 'when token is not expired' do
      let!(:user) { create(:spotify_user, access_token: 'initial_token', access_token_expires_at: 3.days.from_now) }

      it 'leaves the token as is' do
        expect { subject }.not_to change { user.reload.access_token }.from('initial_token')
      end
    end
  end
end
