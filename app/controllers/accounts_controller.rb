class AccountsController < ApplicationController
  # before_action :authenticate!, only: %i[me]
  protect_from_forgery with: :null_session
  skip_before_action :proces_cookies, only: %i[login signup login_form]

  def login
    # @account = Account.find_by!(login_params)
    # @account.authenticate!(params.require(:password))

    # render_one @account
  end

  def signup; end

  def login_form
    @account = Account.find_by!(email: params.require(:email))
    @account.authenticate!(params.require(:password))
    set_account_cookies

    redirect_to root_path
  rescue AuthenticationError => e
    @failed_auth = true
    redirect_to accounts_login_url
  end

  private

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
