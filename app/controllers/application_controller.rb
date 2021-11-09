class ApplicationController < ActionController::API
  include SerializationConcern
  include AuthenticationConcern

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def record_not_found
    render json: { error: 'Record not found' }, status: :not_found
  end
end
