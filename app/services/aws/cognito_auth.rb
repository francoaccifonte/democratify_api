# require_relative '../../poros/integrations/spotify/http_requests'

module Aws
  class CognitoAuth
    include Spotify::HttpRequests

    def token_from_code(code)
      post(
        token_url,
        body: {
          grant_type: 'authorization_code',
          client_id:,
          client_secret:,
          code:,
          redirect_uri:
        }
      )
    end

    def user_from_token(token)
      get(
        user_url,
        headers: {
          Authorization: "Bearer #{token}"
        }
      )
    end

    private

    def redirect_uri
      "https://rockolify.holasoyfranco.com"
    end

    def handle_error(response)
      raise 'error in aws request' if response.code != 200
    end

    def token_url
      "https://rockolify.auth.us-east-2.amazoncognito.com/oauth2/token"
    end

    def user_url
      "https://rockolify.auth.us-east-2.amazoncognito.com/oauth2/userinfo"
    end

    def default_headers
      {
        'Content-Type' => 'application/x-www-form-urlencoded',
      }
    end

    def encoded_secrets
      Base64.encode64("#{client_id}:#{client_secret}")
    end

    def client_id
      ENV.fetch('COGNITO_CLIENT_ID')
    end

    def client_secret
      ENV.fetch('COGNITO_CLIENT_SECRET')
    end
  end
end
