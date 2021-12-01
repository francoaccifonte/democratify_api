module AuthenticationConcern
  extend ActiveSupport::Concern

  def authenticate!
    token = parse_authentication_token!
    @current_account = Account.find_by!(token: token)
  rescue ActiveRecord::RecordNotFound
    raise AuthenticationError.new(token: token)
  end

  def parse_authentication_token!
    token = request.headers['Authorization']
    raise AuthenticationError unless token

    token.split('Bearer ').last
  end
end
