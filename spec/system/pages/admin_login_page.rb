require 'rails_helper'

module Pages
  module AdminLoginPage
    include Capybara::DSL

    module_function

    def login(page, account)
      page.visit Rails.application.routes.url_helpers.accounts_login_url(only_path: true)
      page.fill_in('email', with: account.email)
      page.fill_in('password', with: account.password)
      page.click_on('loginButton')
    end
  end
end
