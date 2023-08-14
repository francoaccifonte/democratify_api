class ApplicationController < ActionController::Base
  attr_reader :account

  before_action :proces_cookies
  before_action :set_player_params
  before_action :set_global_frontend_params

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
    respond_to do |format|
      format.html { redirect_to root_path }
      format.json { render json: { error: 'unauthorized' }, status: :unauthorized }
    end
  end

  # rubocop:disable Naming/MemoizedInstanceVariableName
  def set_player_params
    @ongoing_playlist ||= @account&.ongoing_playlist
    @votation ||= @ongoing_playlist&.votations&.in_progress&.first
  end
  # rubocop:enable Naming/MemoizedInstanceVariableName

  def set_global_frontend_params
    @cognito_endpoint = ENV.fetch('COGNITO_ENDPOINT_URI', nil)
    @backend_base_url = Rails.env.production? ? 'https://rockolify.holasoyfranco.com/spotify_login' : 'http://localhost:3001/spotify_login'
  end

  def update_cognito_cookies
    return if cookies.encrypted[:access_token] && cookies.encrypted[:id_token]
    raise MissingRefreshTokenError if cookies.encrypted[:refresh_token].blank?

    # TODO: fetch new tokens from cognito using the refresh token
  end
end
