class AuthenticationError < ControllerError
  attr_reader :message, :token, :type

  def initialize(type:, message: nil, token: nil)
    super(message:)
    @token = token
    @type = type
  end
end
