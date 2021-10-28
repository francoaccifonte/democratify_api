class WebhookController < ApplicationController

  def spotify_login
    Integration.create!(
      token: params.require(:code),
      provider: 'spotify',
      uuid: params.require(:state)
    )
  end
end
