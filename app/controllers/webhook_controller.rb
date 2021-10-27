class WebhookController < ApplicationController

  def spotify_login
    Integration.create!(
      token: params.require(:code),
      integration_type: 'spotify',
      metadata: {
        state: params.require(:state)
      }
    )
  end
end
