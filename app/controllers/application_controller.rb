class ApplicationController < ActionController::Base
  attr_reader :account

  before_action :proces_cookies

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
    redirect_to root_path
  end
end
