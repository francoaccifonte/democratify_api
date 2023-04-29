# Rspec.shared_context 'with account cookies' do
#   let(:_account)
# end

module WithAccountCookies
  module_function
  def set_account_cookie(cookies, account = nil)
    cookies[:account_id] = account&.id || FactoryBot.create(:account).id
  end
end