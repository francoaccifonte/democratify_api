# frozen_string_literal: true

class WebhookController < ApplicationController
  def spotify_login
    SpotifyUser.authorize_and_create(account_id: params.require(:state), code: params.require(:code))
  end
end
