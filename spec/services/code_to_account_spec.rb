require 'rails_helper'

describe CodeToAccount do
  subject { described_class.call(code:) }

  before do
    stub_const(
      'ENV',
      {
        'COGNITO_CLIENT_SECRET' => 'COGNITO_CLIENT_SECRET_value',
        'COGNITO_CLIENT_ID' => 'COGNITO_CLIENT_ID_value'
      }
    )
    stub_request(:post, "https://rockolify.auth.us-east-2.amazoncognito.com/oauth2/token")
      .with(
        body: {
          "client_id" => 'COGNITO_CLIENT_ID_value',
          "client_secret" => 'COGNITO_CLIENT_SECRET_value',
          "code" => code,
          "grant_type" => "authorization_code",
          "redirect_uri" => "https://rockolify.holasoyfranco.com"
        },
        headers: {
          'Content-Type' => 'application/x-www-form-urlencoded'
        }
      )
      .to_return(status: 200, body: token_endpoint_response, headers: {})

    stub_request(:get, "https://rockolify.auth.us-east-2.amazoncognito.com/oauth2/userinfo")
      .with(
        headers: {
          Authorization: 'Bearer mock_access_token'
        }
      )
      .to_return(status: 200, body: user_info_endpoint_response, headers: {})
  end

  let!(:code) { "fakeAccessCode" }
  let(:token_endpoint_response) do
    JSON(
      {
        id_token: "mock_id_token",
        access_token: "mock_access_token",
        refresh_token: "mock_refresh_token",
        expires_in: 3600,
        token_type: "Bearer"
      }
    )
  end
  let(:user_info_endpoint_response) do
    JSON(
      {
        sub: "1fae5841-4321-477b-9073-2d34812123bb",
        email_verified: "true",
        email: "pepe@example.com",
        username: "1fae5841-7765-477b-9073-2d346565e3bb"
      }
    )
  end

  context 'when account already exists,' do
    let!(:account) { create(:account, email: "pepe@example.com") }

    it 'returns the existing account' do
      returned_account = subject
      expect(returned_account.fetch(:account).id).to eq(account.id)
    end
  end

  context 'when account does not exist,' do
    it 'creates a new account' do
      expect { subject }.to change(Account, :count).by(1)
    end

    it 'assigns the correct values' do
      expect(
        subject.fetch(:account).attributes >= {
          'email' => 'pepe@example.com',
          'name' => '1fae5841-7765-477b-9073-2d346565e3bb'
        }
      ).to be true
    end

    it 'also returns tokens' do
      expect(subject.fetch(:tokens) >= JSON.parse(token_endpoint_response, symbolize_names: true)).to be true
    end
  end
end
