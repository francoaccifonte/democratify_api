class ControllerError < StandardError
  attr_reader :status, :message

  def initialize(status: nil, message: nil)
    super(message)
    @status = status
    @message = message
  end
end
