require 'rails_helper'
require_relative './pages/admin_login_page'

RSpec.describe 'giving permissions to spotify', js: true do
  let(:account) { create(:account) }

  before { WithAccountCookies.set_account_cookie(cookies, account) }

  it 'shows the right content' do
    Pages::AdminLoginPage.login(page, account)
    visit account_settings_url(only_path: true)
    expect(page).to have_content('Enlaza tu cuenta de Streaming')
  end
end
