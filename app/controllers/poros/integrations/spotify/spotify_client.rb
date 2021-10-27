class SpotifyClient
  CLIENT_SECRET = 'ddd04fa7c1b746d18d4c2cf707604dec'.freeze
  CLIENT_ID = '9d48abfbbf194adc9051e1b82b0ecdb0'.freeze
  REDIRECT_URI = 'http://localhost:3001/spotify_login'.freeze

  def login()
    "https://accounts.spotify.com/authorize?client_id=#{CLIENT_ID}&response_type=code&redirect_uri=#{REDIRECT_URI}&scope=user-read-private%20user-read-email&state=34fFs29kd09"
    
  end
end
