# frozen_string_literal: true

module Api
  class WebhookController < Api::ApiController
    def spotify_login
      SpotifyUserAuthorizer.call(account_id: params.require(:state), code: params.require(:code))

      render json: {}, status: :ok
    end
  end
end
