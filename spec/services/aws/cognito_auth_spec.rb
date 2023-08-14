require 'rails_helper'

RSpec.describe Aws::CognitoAuth do
  describe '#token_from_code' do
    subject { described_class.new.token_from_code(code) }

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
            "code" => "someCode",
            "grant_type" => "authorization_code",
            "redirect_uri" => "https://rockolify.holasoyfranco.com"
          },
          headers: {
            'Content-Type' => 'application/x-www-form-urlencoded'
          }
        )
        .to_return(status: 200, body: response_body, headers: {})
    end

    let(:code) { 'someCode' }
    let(:response_body) do
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

    context 'when successful' do
      it 'returns the expected hash' do
        expect(subject >= JSON.parse(response_body, symbolize_names: true)).to be true
      end
    end
  end
end
