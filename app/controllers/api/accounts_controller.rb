module Api
  class AccountsController < ApiController
    before_action :authenticate!, only: %i[me]

    def me
      render_one @current_account
    end

    def login
      @account = Account.find_by!(login_params)
      @account.authenticate!(params.require(:password))
      set_account_cookie

      render_one @account
    end

    def signup
      @account = Account.new(signup_params)
      @account.password = params.require(:password)
      @account.save!

      render_one @account
    end

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
end
