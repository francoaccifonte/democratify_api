module Telegram
  module Responses
    extend ActiveSupport::Concern

    def send_help(chat_id)
      response = <<~HEREDOC
        /help
        /whitelist <<account_id>>
      HEREDOC
      send_message(chat_id:, text: response)
    end
  end
end
