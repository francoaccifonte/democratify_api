class AccountsController < ApplicationController
  before_action :authenticate!, only: %i[me]

  def me
    render_one @current_account
  end

  def login
    @account = Account.find_by(login_params)

    render_one @account
  end

  private

  def login_params
    params.permit(:email)
  end
end
