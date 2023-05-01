class InvalidAccountCookiesError < StandardError; end

class ApplicationController < ActionController::Base
  attr_reader :account

  before_action :proces_cookies

  rescue_from InvalidAccountCookiesError, with: -> { redirect_to root_path }

  def proces_cookies
    process_account_cookies
  end

  protected

  def process_account_cookies
    found_account = Account.find(cookies[:account_id])
    validate_account_cookies!(found_account)

    @account = found_account
  rescue ActiveRecord::RecordNotFound
    raise InvalidAccountCookiesError, "invalid auth"
  end

  def validate_account_cookies!(found_account)
    return if found_account.token == cookies[:token]

    cookies.delete(:account_id)
    cookies.delete(:token)
    raise InvalidAccountCookiesError, 'provided token is invalid'
  end
end
