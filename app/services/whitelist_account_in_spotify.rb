class WhitelistAccountInSpotify
  TELEGRAM_TOKEN = ENV.fetch('TELEGRAM_TOKEN')
  TELEGRAM_CHAT_ID = ENV.fetch('TELEGRAM_CHAT_ID').to_i

  def initialize(account_id:, email:)
    @account_id = account_id
    @account = Account.find(account_id)
    @email = email
  end

  def self.call(*args, **kwargs)
    new(*args, **kwargs).call
  end

  def call
    client.send_message(
      chat_id: TELEGRAM_CHAT_ID,
      text: message
    )
  end

  private

  def client
    Telegram::Client.new
  end

  def message
    <<~HEREDOC
      #{Time.current}
      Alguien se suscribio a Rockolify!
      Agregalo a la lista de usuarios permitidos en https://developer.spotify.com/dashboard/9d48abfbbf194adc9051e1b82b0ecdb0/users
      email: #{@email}
      account_id: #{@account_id}
      account_name: #{@account.name}
    HEREDOC
  end

  attr_reader :email, :account_id
end
