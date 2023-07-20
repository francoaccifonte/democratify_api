class SpotifyUsersController < ApplicationController
  include SerializationConcern

  # POST /spotify_users
  def create
    SpotifyUser.transaction do
      @spotify_user = SpotifyUser.create!(
        account_id: @account.id,
        user_provided_email: params.require(:email)
      )
      WhitelistAccountInSpotify.call(account_id: @account.id, email: params.require(:email))
    end

    respond_to do |format|
      format.json do
        render json: serialize_one(@spotify_user), status: :ok
      end
      format.html do
        redirect_to account_settings_path
      end
    end
  end
end
