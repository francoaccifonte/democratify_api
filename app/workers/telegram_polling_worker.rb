class TelegramPollingWorker
  TELEGRAM_TOKEN = ENV['TELEGRAM_TOKEN'].freeze

  include Sidekiq::Worker

  def perform # rubocop:disable Metrics/AbcSize
    messages = client.list_updates
    raise unless messages[:ok]

    messages = messages[:result]
    return unless messages.any?

    messages.each do |message|
      case message[:message][:text]
      when %r{/help}
        client.send_help(message[:message][:chat][:id])
      when %r{/whitelist}
        whitelist(message)
      when /refresh_playlists/
        refresh_playlists(message)
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

  def refresh_playlists(message)
    cmd = message[:message][:text]
    account = Account.find cmd.split.last.to_i

    PlaylistImportWorker.perform_async(account.spotify_user.id)
  end
end
