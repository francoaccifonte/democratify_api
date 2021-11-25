# frozen_string_literal: true

module Spotify
  module Users
    extend ActiveSupport::Concern

    def user
      get("#{self.class::SPOTIFY_URL}/me")
    end
  end
end
