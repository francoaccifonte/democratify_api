class TelegramPollingWorker
  TELEGRAM_TOKEN = ENV.fetch('TELEGRAM_TOKEN')

  include Sidekiq::Worker
  sidekiq_options queue: :default

  def perform # rubocop:disable Metrics/AbcSize
    messages = client.list_updates
    raise unless messages[:ok]

    messages = messages[:result]
    messages.each do |message|
      case message[:message][:text]
      when %r{/help}
        client.send_help(message[:message][:chat][:id])
      when %r{/whitelist}
        whitelist(message)
      end
    end

    client.list_updates(offset: messages.last[:update_id] + 1)
  end

  def client
    Telegram::Client.new
  end

  def whitelist(message)
    cmd = message[:message][:text]
    chat_id = message[:message][:chat][:id]
    account_id = cmd.split.last.to_i

    SpotifyUser.find_by!(account_id:).update!(whitelisted: true)

    client.send_message(chat_id:, text: "whitelisted account with id #{account_id}")
  end
end
