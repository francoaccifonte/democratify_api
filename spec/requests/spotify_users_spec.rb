require 'rails_helper'

RSpec.describe "/spotify_users" do
  let!(:account) { create(:account) }

  context 'json request' do
    subject { post(spotify_users_path, params: { format: :json, email: user_email }) }

    let(:user_email) { Faker::Internet.email }

    context 'with correct parameters' do
      before do
        WithAccountCookies.set_account_cookie(cookies, account)
        allow(WhitelistAccountInSpotify).to receive(:call).and_return(true)
      end

      it 'creates a spotify_user' do
        expect { subject }.to change(SpotifyUser, :count).by(1)
        expect(SpotifyUser.last.account_id).to eq(account.id)
      end

      it 'whitelists it in spotify' do
        subject
        expect(WhitelistAccountInSpotify).to have_received(:call).with(account_id: account.id, email: user_email)
      end

      it 'gives the proper response' do
        subject
        body = JSON.parse(response.body, symbolize_names: true)
        expect(body[:user_provided_email]).to eq(user_email)
        expect(body[:account_id]).to eq(account.id)
      end

      # context 'when whitelisting fails' do
      #   before { allow(WhitelistAccountInSpotify).to receive(:call).and_raise(StandardError.new('some error occured')) }

      #   it 'does not create a new user' do
      #     expect { subject }.not_to change(SpotifyUser, :count)
      #   end
      # end
    end

    context 'without cookies' do
      it 'creates a spotify_user' do
        subject
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
