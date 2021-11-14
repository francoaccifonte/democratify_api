module AuthenticationConcern
  extend ActiveSupport::Concern

  def authenticate!
    @current_account = Account.find_by!(token: parse_authentication_token!)
  end

  def parse_authentication_token!
    token = request.headers['Authorization']
    raise AuthenticationError unless token

    token.split('Bearer ').last
  end
end
