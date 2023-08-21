class ApplicationController < ActionController::Base
  include ReactComponentConcern
  attr_reader :account

  before_action :proces_cookies
  before_action :set_player_params

  rescue_from InvalidAccountCookiesError, with: :handle_invalid_cookies

  def proces_cookies
    process_account_cookies
  end

  private

  def process_account_cookies
    found_account = Account.find(cookies[:account_id])
    validate_account_cookies!(found_account)

    @account = found_account
  rescue ActiveRecord::RecordNotFound
    Rails.logger.debug { "Account not found for id #{cookies[:account_id]}" }
    raise InvalidAccountCookiesError, "invalid auth"
  end

  def validate_account_cookies!(found_account)
    return if found_account.token == cookies[:token]

    Rails.logger.debug { 'Clearing account cookies' }
    cookies.delete(:account_id)
    cookies.delete(:token)
    raise InvalidAccountCookiesError, 'provided token is invalid'
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
end
