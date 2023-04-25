class AccountsController < ApplicationController
  # before_action :authenticate!, only: %i[me]
  protect_from_forgery with: :null_session

  def login
    # @account = Account.find_by!(login_params)
    # @account.authenticate!(params.require(:password))

    # render_one @account
  end

  def signup; end

  private

  def login_params
    params.permit(:email)
  end

  def signup_params
    {
      email: params.require(:email)
    }.merge!(params.permit(:name)).compact
  end
end
