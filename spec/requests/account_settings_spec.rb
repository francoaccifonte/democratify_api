require 'rails_helper'

RSpec.describe "/account_settings" do
  describe "GET /index" do
    let(:account) { create(:account) }

    before { WithAccountCookies.set_account_cookie(cookies, account) }

    it "renders a successful response" do
      get account_settings_url
      expect(response).to be_successful
    end
  end
end
