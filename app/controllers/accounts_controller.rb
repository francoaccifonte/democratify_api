class AccountsController < ApplicationController
  skip_before_action :proces_cookies, only: %i[login signup login_form]
  before_action :redirect_if_already_loged_in, only: %i[login signup login_form]

  def login; end

  def signup; end

  def login_form
    @account = Account.find_by!(email: params.require(:email))
    @account.authenticate!(params.require(:password))
    set_account_cookies

    redirect_to spotify_playlists_url
  rescue AuthenticationError
    Rails.logger.debug('login failed')
    @failed_auth = true
    render :login, status: :unauthorized
  end

  def cognito_endpoint # rubocop:disable Metrics/AbcSize
    data = CodeToAccount.call(params.require(:code))
    cookies[:account_id] = data.fetch(:account).id
    cookies[:cognito_tokens] = data.fetch(:tokens)

    return redirect_to(account_settings_path) if data[:account].spotify_user.blank?

    redirect_to(spotify_playlists_url)
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
end
