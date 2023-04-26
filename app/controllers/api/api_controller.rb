module Api
  class ApiController < ActionController::API
    include SerializationConcern
    include AuthenticationConcern
    include ErrorHandlingConcern
  end
end
