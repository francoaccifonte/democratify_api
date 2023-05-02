require 'rails_helper'

RSpec.describe "/account_settings" do
  describe "GET /index" do
    it "renders a successful response" do
      get account_settings_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      get account_setting_url(account_setting)
      expect(response).to be_successful
    end
  end
end
