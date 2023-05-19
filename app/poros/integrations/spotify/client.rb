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
    REDIRECT_URI = (Rails.env.production? ? 'http://rockolify.click:3001/spotify_login' : 'http://localhost:3001/spotify_login').freeze

    SPOTIFY_URL = 'https://api.spotify.com/v1'

    def self.from_user(user)
      client = new(access_token: user.access_token, refresh_token: user.refresh_token)
      SpotifyUserTokenRefresher.call(user:)
      client
    end

    attr_accessor :login_token, :access_token, :refresh_token

    def initialize(access_token: nil, login_token: nil, refresh_token: nil)
      @access_token = access_token # the one you use to access the api
      @refresh_token = refresh_token # the one you use to get a new access token
      @login_token = login_token # the one you use for the first time. See webhook controller
    end

    def handle_error(response)
      return if response.success?

      case response.code
      when 401, 404
        Rails.logger.debug response.body
      end

      raise Errors::SpotifyError.new(response.body, response)
    end
  end
end
