# frozen_string_literal: true

module Spotify
  class Client
    include HttpRequests
    include Credentials
    include Users
    include Playlists
    include RemotePlayer

    CLIENT_SECRET = ENV['SPOTIFY_SECRET'].freeze
    CLIENT_ID = ENV['SPOTIFY_CLIENT_ID'].freeze
    REDIRECT_URI = ENV['SPOTIFY_REDIRECT_URL'].freeze

    SPOTIFY_URL = 'https://api.spotify.com/v1'

    attr_accessor :login_token

    def initialize(user: nil, login_token: nil, **_other)
      @user = user
      @login_token = login_token
    end

    def access_token
      @user&.access_token
    end

    def refresh_token
      @user&.refresh_token
    end

    def handle_error(response)
      return if response.success?

      case response.code
      when 401
        Rails.logger.debug response.body
      when 404
        Rails.logger.debug response.body
      end

      raise Errors::SpotifyError.new(response.body, response)
    end
  end
end
