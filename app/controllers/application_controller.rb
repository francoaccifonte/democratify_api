class InvalidAccountCookiesError < StandardError; end

class ApplicationController < ActionController::Base
  attr_reader :account

  before_action :proces_cookies

  rescue_from InvalidAccountCookiesError, with: -> () { redirect_to root_path }

  def proces_cookies
    process_account_cookies
  end

  protected

  def process_account_cookies
    found_account = Account.find(cookies[:account_id]) 
    return @account = found_account if found_account.token == cookies[:token]

    # TODO: Test this bit
    raise InvalidAccountCookiesError.new("invalid auth")
  rescue ActiveRecord::RecordNotFound => e
    raise InvalidAccountCookiesError.new("invalid auth")
  end
end
