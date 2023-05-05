require 'rails_helper'
require_relative './pages/admin_login_page'

RSpec.describe 'giving permissions to spotify', js: true do
  context 'with correct credentials' do
    it 'creates the account' do
      page.visit accounts_signup_path(only_path: true)
      expect(page).to have_content('USUARIO')
      expect(page).to have_content('CONTRASEÑA')
      expect(page).to have_content('CONFIRMAR CONTRASEÑA')
      expect(page).to have_content('CORREO ELECTRÓNICO')

      account_attributes = attributes_for(:account)

      page.fill_in('email', with: account_attributes[:email])
      page.fill_in('password', with: account_attributes[:password])
      page.fill_in('repeatPassword', with: account_attributes[:password])
      page.fill_in('user', with: account_attributes[:name])

      page.click_on('signupButton')
      # byebug

      account = Account.find_by!(email: account_attributes[:email])
      Pages::AdminLoginPage.login(page, account)
      # After login you're redirected to spotify_playlists view
      expect(page.current_url).to include(spotify_playlists_path)
    end
  end
end
