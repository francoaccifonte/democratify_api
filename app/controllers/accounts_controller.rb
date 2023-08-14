class AccountsController < ApplicationController
  skip_before_action :proces_cookies, only: %i[login signup login_form]
  before_action :redirect_if_already_loged_in, only: %i[login signup login_form]

  def login; end

  def signup; end

  def login_form
    @account = Account.find_by!(email: params.require(:email))
    @account.authenticate!(params.require(:password))
    set_account_cookies

    login_redirect
  rescue AuthenticationError
    Rails.logger.debug('login failed')
    @failed_auth = true
    render :login, status: :unauthorized
  end

  private

  def redirect_if_already_loged_in
    redirect_to spotify_playlists_url if cookies[:account_id].present?
  end

  def set_account_cookies
    cookies[:account_id] = @account.id
    cookies[:token] = @account.token
  end

  def signup_params
    {
      email: params.require(:email)
    }.merge!(params.permit(:name)).compact
  end

  def login_redirect
    redirect_to(@account.spotify_user.present? ? spotify_playlists_url : account_settings_url)
  end
end
