class ApplicationController < ActionController::Base
  attr_reader :account

  before_action :proces_cookies
  before_action :set_player_params

  rescue_from InvalidAccountCookiesError, with: :handle_invalid_cookies
  rescue_from MissingRefreshTokenError, with: :handle_invalid_cookies

  def proces_cookies
    update_cognito_cookies
    process_account_cookies
  end

  private

  def process_account_cookies
    found_account = Account.find(cookies.encrypted[:account_id])
    validate_account_cookies!(found_account)

    @account = found_account
  rescue ActiveRecord::RecordNotFound
    Rails.logger.debug { "Account not found for id #{cookies.encrypted[:account_id]}" }
    raise InvalidAccountCookiesError, "invalid auth"
  end

  def validate_account_cookies!(found_account)
    id_token = JWT.decode(cookies.encrypted[:id_token], nil, false).first.with_indifferent_access # .last returns algorithm
    return if id_token[:email] == found_account.email

    Rails.logger.debug { 'invalid cookies' }
    raise InvalidAccountCookiesError, 'provided id_token.email differs from account.email'
  end

  def handle_invalid_cookies
    Rails.logger.debug { 'Invalid cookies' }
    cookies.delete(:account_id)
    cookies.delete(:id_token)
    cookies.delete(:access_token)
    redirect_to root_path
  end

  # rubocop:disable Naming/MemoizedInstanceVariableName
  def set_player_params
    @ongoing_playlist ||= @account&.ongoing_playlist
    @votation ||= @ongoing_playlist&.votations&.in_progress&.first
  end
  # rubocop:enable Naming/MemoizedInstanceVariableName

  def update_cognito_cookies
    return if cookies.encrypted[:access_token] && cookies.encrypted[:id_token]
    raise MissingRefreshTokenError if cookies.encrypted[:refresh_token].blank?

    # TODO: fetch new tokens from cognito using the refresh token
  end
end
