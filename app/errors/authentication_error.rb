class AuthenticationError < ApplicationError
  attr_reader :message, :token

  def initialize(message, token: nil)
    super(message)
    @token = token
  end
end
