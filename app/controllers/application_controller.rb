class ApplicationController < ActionController::API
  include SerializationConcern
  include AuthenticationConcern

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from AuthenticationError, with: :authentication_error

  def record_not_found
    render json: { error: 'Record not found' }, status: :not_found
  end

  def authentication_error(error)
    body = error.token ? { error: 'Authentication token required' } : { error: 'Invalid token' }

    render json: body, status: :unauthorized
  end

  def render_no_content
    render json: {}, status: :no_content
  end
end
