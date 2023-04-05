# frozen_string_literal: true

module Spotify
  module Credentials
    extend ActiveSupport::Concern

    def authorize
      body = {
        grant_type: 'authorization_code',
        code: login_token,
        redirect_uri: self.class::REDIRECT_URI,
        client_id: self.class::CLIENT_ID,
        client_secret: self.class::CLIENT_SECRET
      }

      post('https://accounts.spotify.com/api/token', body:, headers: _url_encoded_content_type)
    end

    def refresh_access_token!
      body = {
        grant_type: 'refresh_token',
        refresh_token:,
        client_id: self.class::CLIENT_ID
      }
      headers = _url_encoded_content_type.merge(_encoded_credentials)
      post('https://accounts.spotify.com/api/token', body:, headers:)
    end

    private

    def _url_encoded_content_type
      { 'Content-Type' => 'application/x-www-form-urlencoded' }
    end

    def _encoded_credentials
      { Authorization: "Basic #{Base64.strict_encode64("#{self.class::CLIENT_ID}:#{self.class::CLIENT_SECRET}")}" }
    end
  end
end
