class ApplicationController < ActionController::API
  include SerializationConcern
  include AuthenticationConcern
  include ErrorHandlingConcern
end
