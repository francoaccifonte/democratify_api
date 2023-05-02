class AccountSettingsController < ApplicationController
  # GET /account_settings
  def index
    @account_settings = AccountSetting.all
  end

  # GET /account_settings/1
  def show
  end
end
