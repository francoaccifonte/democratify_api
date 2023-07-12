# frozen_string_literal: true

module Api
  class WebhookController < ApplicationController
    def spotify_login
      SpotifyUserCreator.call(account_id: params.require(:state), code: params.require(:code))

      redirect_to spotify_playlists_url
    end
  end
end
