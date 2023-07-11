module AccountSettingsHelper
  include ApplicationHelper

  SPOTIFY_CLIENT_ID = ENV['SPOTIFY_CLIENT_ID'].to_s.freeze
  DEFAULT_SPOTIFY_SCOPES = %w[user-read-email playlist-read-private playlist-read-collaborative user-read-playback-state user-modify-playback-state user-read-currently-playing].freeze

  def spotify_redirect_uri(account)
    'https://accounts.spotify.com/authorize?' \
      'response_type=code&' \
      "client_id=#{SPOTIFY_CLIENT_ID}&" \
      "scope=#{DEFAULT_SPOTIFY_SCOPES.join('%20')}&" \
      "redirect_uri=#{redirect_uri}&" \
      "state=#{account.id}"
  end

  def redirect_uri
    # TODO: change this with an env variable
    Rails.env.production? ? 'https://rockolify.holasoyfranco.com/spotify_login' : 'http://localhost:3001/spotify_login'
  end
end
