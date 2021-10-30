class WebhookController < ApplicationController

  def spotify_login
    client = Spotify::Client.new(login_token: params.require(:code))
    auth_response = client.authorize

    client.access_token = auth_response[:access_token]
    user_data = client.user

    user = SpotifyUser.find_or_initialize_by(
      spotify_id: user_data[:id]
    )
    user.assign_attributes(
      name: user_data[:display_name],
      email: user_data[:email],
      uri: user_data[:uri],
      scope: auth_response[:scope],
      access_token: auth_response[:access_token],
      access_token_expires_at: Time.zone.now + auth_response[:expires_in].seconds,
      refresh_token: auth_response[:refresh_token],
      href: user_data[:href],
    )
    user.save!
  end
end
