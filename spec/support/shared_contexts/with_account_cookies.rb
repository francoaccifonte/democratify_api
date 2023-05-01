# Rspec.shared_context 'with account cookies' do
#   let(:_account)
# end

module WithAccountCookies
  module_function

  def set_account_cookie(cookies, account)
    cookies[:account_id] = account.id
    cookies[:token] = account.token
  end
end
