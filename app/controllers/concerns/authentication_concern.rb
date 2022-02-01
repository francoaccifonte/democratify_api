module AuthenticationConcern
  extend ActiveSupport::Concern

  def authenticate!
    token = parse_authentication_token!
    @current_account = Account.find_by!(token: token)
  rescue ActiveRecord::RecordNotFound
    raise AuthenticationError.new(type: :invalid_token, token: token)
  end

  def parse_authentication_token!
    token = request.headers['Authorization']
    raise AuthenticationError.new(type: :missing_token) unless token

    token.split('Bearer ').last
  end
end
