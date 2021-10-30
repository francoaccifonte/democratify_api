class WebhookController < ApplicationController
  def spotify_login
    Integration.create!(
      type_in_chain: 'front_end_token',
      token: params.require(:code),
      provider: 'spotify',
      uuid: params.require(:state)
    )
  end
end
