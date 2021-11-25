class AuthenticationError < ControllerError
  attr_reader :message, :token

  def initialize(message: nil, token: nil)
    super(message: message)
    @token = token
  end
end
