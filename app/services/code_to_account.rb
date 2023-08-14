class CodeToAccount
  def initialize(code:)
    @code = code
  end

  def self.call(*args, **kwargs)
    new(*args, **kwargs).call
  end

  def call
    @tokens = Aws::CognitoAuth.new.token_from_code(code)
    user_info = Aws::CognitoAuth.new.user_from_token(tokens[:access_token])

    response(Account.find_by!(email: user_info.fetch(:email)))
  rescue ActiveRecord::RecordNotFound
    response(
      Account.create!(
        email: user_info.fetch(:email),
        name: user_info.fetch(:username, nil)
      )
    )
  end

  private

  attr_reader :tokens, :code

  def client
    @client ||= Spotify::Client.new(access_token: nil, login_token: nil, refresh_token: user.refresh_token)
  end

  def response(account)
    {
      account:,
      tokens:
    }
  end
end
