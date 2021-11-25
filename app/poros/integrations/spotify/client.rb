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

    SPOTIFY_URL = 'https://api.spotify.com/v1'.freeze

    attr_accessor :access_token, :login_token, :refresh_token

    def initialize(login_token: nil, access_token: nil, refresh_token: nil)
      @access_token = access_token
      @login_token = login_token
      @refresh_token = refresh_token
    end

    def handle_error(response)
      return unless response.success?

      case response.code
      when 401
        puts 410
      when 404
        puts 303
      end
    end
  end
end
