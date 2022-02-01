module ErrorHandlingConcern
  extend ActiveSupport::Concern

  included do
    rescue_from ControllerError, with: :controller_error
    rescue_from AuthenticationError, with: :authentication_error

    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    rescue_from ActionController::ParameterMissing, with: :parameter_missing
  end

  def controller_error(error)
    render json: { error: error.message }, status: error.status
  end

  def authentication_error(error)
    body = {
      invalid_token:
             { error: 'Invalid token' },
      missing_token:
             { error: 'Authentication token required' },
      invalid_password:
             { error: 'Password is invalid' }
    }.fetch(error.type)

    render json: body, status: :unauthorized
  end

  def record_not_found
    render json: { error: 'Record not found' }, status: :not_found
  end

  def parameter_missing(error)
    render json: { error: "Missing parameter: #{error.param}" }, status: :bad_request
  end
end
