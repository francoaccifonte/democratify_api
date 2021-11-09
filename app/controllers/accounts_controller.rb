class AccountsController < ApplicationController
  def login
    @account = Account.find_by(login_params)

    render_one @account
  end

  private

  def login_params
    params.permit(:email)
  end
end
