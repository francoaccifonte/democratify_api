class SpotifyUserTokenRefresher
  def initialize(user:)
    @user = user
  end

  def self.call(*args, **kwargs)
    new(*args, **kwargs).call
  end

  def call
    return unless user.access_token_expired?

    response = client.refresh_access_token!
    @user.access_token = response.fetch(:access_token)
    @user.access_token_expires_at = Time.zone.now + response.fetch(:expires_in).seconds
    @user.save!
  end

  private

  attr_reader :user

  def client
    @client ||= Spotify::Client.new(access_token: nil, login_token: nil, refresh_token: user.refresh_token)
  end
end
