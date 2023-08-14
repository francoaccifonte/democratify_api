# Rspec.shared_context 'with account cookies' do
#   let(:_account)
# end

module WithAccountCookies
  module_function

  def set_account_cookie(cookies, account) # rubocop:disable Metrics/AbcSize
    my_cookies = ActionDispatch::Request.new(Rails.application.env_config.deep_dup).cookie_jar
    my_cookies.encrypted[:id_token] = id_token(account)
    my_cookies.encrypted[:access_token] = access_token(account)
    my_cookies.encrypted[:refresh_token] = "SomeRefreshToken"
    my_cookies.encrypted[:account_id] = account.id

    cookies[:id_token] = my_cookies[:id_token]
    cookies[:access_token] = my_cookies[:access_token]
    cookies[:refresh_token] = my_cookies[:refresh_token]
    cookies[:account_id] = my_cookies[:account_id]
  end

  def id_token(account) # rubocop:disable Metrics/MethodLength
    JWT.encode(
      {
        at_hash: "noIdeaWhatThisIs--at_hash",
        sub: "noIdeaWhatThisIs--sub",
        email_verified: true,
        iss: "https://cognito-idp.us-east-N.amazonaws.com/us-east-N_AAAAAAAAA",
        'cognito:username': "noIdeaWhatThisIs--cognito:username",
        origin_jti: "noIdeaWhatThisIs--origin_jti",
        aud: "noIdeaWhatThisIs--aud",
        token_use: "id",
        auth_time: 1_689_612_743,
        exp: 1_689_616_343,
        iat: 1_689_612_743,
        jti: "noIdeaWhatThisIs--jti",
        email: account.email
      },
      'HS512',
      'HS512'
    )
  end

  def access_token(account) # rubocop:disable Metrics/MethodLength
    JWT.encode(
      {
        sub: "noIdeaWhatThisIs--sub",
        iss: "https://cognito-idp.us-east-N.amazonaws.com/us-east-N_AAAAAAAAA",
        version: 2,
        client_id: "noIdeaWhatThisIs--client_id",
        origin_jti: "noIdeaWhatThisIs--origin_jti",
        token_use: "access",
        scope: "openid email",
        auth_time: 1_689_612_743,
        exp: 1_689_616_343,
        iat: 1_689_612_743,
        jti: "noIdeaWhatThisIs--jti",
        username: account.name
      },
      'HS512',
      'HS512'
    )
  end
end
