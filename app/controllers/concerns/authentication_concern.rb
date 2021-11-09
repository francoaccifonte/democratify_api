module AuthenticationConcern
  extend ActiveSupport::Concern

  def authenticate!
    @current_account = Account.find_by!(token: request.headers.fetch('Authorization'))
  end
end
