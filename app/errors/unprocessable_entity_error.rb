class UnprocessableEntityError < ControllerError
  def initialize(message: 'Unprocessable Entity', status: 422)
    super(status:, message:)
  end
end
