class ApplicationError < StandardError
  attr_reader :status, :message

  def initialize(status, message)
    super(message)
    @status = status
    @message = message
  end
end
