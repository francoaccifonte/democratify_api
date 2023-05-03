require 'rails_helper'
require_relative './pages/admin_login_page'

RSpec.describe 'giving permissions to spotify', js: true do
  let(:account) { create(:account) }

  context 'with correct credentials' do
    it 'shows the right content' do
      page.visit accounts_login_path(only_path: true)
      expect(page).to have_content('EMAIL')
      expect(page).to have_content('CONTRASEÑA')

      Pages::AdminLoginPage.login(page, account)
      # After login you're redirected to spotify_playlists view
      expect(page.current_url).to include(spotify_playlists_path)
    end
  end

  context 'with invalid credentials' do
    it 'shows an error message' do
      page.visit accounts_login_path(only_path: true)
      page.fill_in('email', with: account.email)
      page.fill_in('password', with: "fakePassword#{account.password}")
      page.click_on('loginButton')

      expect(page).to have_content('Usuario o contraseña incorrectos')
    end
  end
end
