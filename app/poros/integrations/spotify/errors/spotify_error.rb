# frozen_string_literal: true

module Spotify
  module Errors
    class SpotifyError < StandardError
      attr_reader :response, :message

      def initialize(message, response)
        @message = message
        @response = response
      end
    end
  end
end
