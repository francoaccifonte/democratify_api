module Telegram
  class Client
    TELEGRAM_TOKEN = ENV['TELEGRAM_TOKEN'].freeze
    TELEGRAM_BASE_URL = "https://api.telegram.org/bot#{TELEGRAM_TOKEN}".freeze

    include Spotify::HttpRequests
    include Responses

    def list_updates(offset: nil)
      query_params = offset ? { offset: } : {}
      get("#{TELEGRAM_BASE_URL}/getUpdates", query_params:)
    end

    def send_message(chat_id:, text:)
      Rails.logger.info("sending message #{text}")
      body = {
        chat_id:,
        text:
      }
      post("#{TELEGRAM_BASE_URL}/sendMessage", body:)
    end

    private

    def default_headers
      {}
    end

    def handle_error(response); end
  end
end
