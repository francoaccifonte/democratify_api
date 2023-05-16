# == Schema Information
#
# Table name: accounts
#
#  id              :bigint           not null, primary key
#  email           :string           not null
#  name            :string
#  password_digest :string
#  token           :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_accounts_on_email  (email) UNIQUE
#  index_accounts_on_name   (name) UNIQUE
#
require 'rails_helper'

RSpec.describe(Account) do
  describe "password encryption" do
    it "encrypts the password" do
      account = described_class.create(email: "test@example.com", password: "password")
      expect(account.password_digest).not_to be_nil
    end
  end

  describe "#set_token" do
    it "generates a unique token" do
      account = described_class.create(email: "test@example.com", password: "password")
      expect(account.token).not_to be_nil
      expect(account.token).to be_a(String)
      expect(described_class.where(token: account.token).count).to eq(1)
    end
  end

  describe "#authenticate!" do
    it "authenticates a user with a valid password" do
      account = described_class.create(email: "test@example.com", password: "password")
      authenticated_account = account.authenticate!("password")
      expect(authenticated_account).to eq(account)
    end

    it "raises an AuthenticationError with an invalid password" do
      account = described_class.create(email: "test@example.com", password: "password")
      expect do
        account.authenticate!("invalid_password")
      end.to raise_error(AuthenticationError, "invalid password")
    end
  end
end
