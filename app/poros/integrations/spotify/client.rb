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

    attr_accessor :access_token, :login_token, :refresh_token

    def initialize(user: nil, login_token: nil, access_token: nil, refresh_token: nil)
      @user = user
      @access_token = access_token
      @login_token = login_token
      @refresh_token = refresh_token
    end

    def handle_error(response)
      return unless response.success?

      case response.code
      when 401
        puts response
      when 404
        puts response
      end
    end
  end
end
