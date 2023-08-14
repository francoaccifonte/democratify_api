class SpotifyUserAuthorizer
  def initialize(account_id:, code:)
    @account_id = account_id
    @code = code
    @client = Spotify::Client.new(access_token: nil, login_token: code, refresh_token: nil)
  end

  def self.call(*args, **kwargs)
    new(*args, **kwargs).call
  end

  def call
    user = SpotifyUser.find_by!(account_id:)
    authorize(user)
    user_data(user)

    user.save!
    PlaylistImportWorker.perform_async(user.id)
  end

  private

  attr_reader :account_id, :code, :client

  def authorize(user) # rubocop:disable Metrics/AbcSize
    auth_response = client.authorize
    client.access_token = auth_response[:access_token]
    client.refresh_token = auth_response[:refresh_token]
    user.assign_attributes(
      scope: auth_response[:scope],
      access_token: auth_response[:access_token],
      access_token_expires_at: Time.zone.now + auth_response[:expires_in].seconds,
      refresh_token: auth_response[:refresh_token]
    )
  end

  def user_data(user)
    user_data = client.user
    user.assign_attributes(
      spotify_id: user_data[:id],
      name: user_data[:display_name],
      email: user_data[:email],
      uri: user_data[:uri],
      href: user_data[:href]
    )
  end
end
