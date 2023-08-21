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

describe AccountSerializer do
  subject { described_class.new.serialize_to_json(account) }

  let!(:account) { create(:account) }

  it 'contains the correct attributes' do
    %i[id email name created_at updated_at spotify_user].each do |attribute|
      expect(subject).to include("\"#{attribute}\":")
      expect(subject).to include(account.attributes[attribute].to_s) if account.attributes[attribute]
    end
  end

  context 'when it has nested records' do
    let!(:spotify_user) { create(:spotify_user, account:) }

    it 'contains associated records' do
      expect(subject).to include("\"spotify_user\":")
      expect(subject).to include(spotify_user.id.to_s)
    end
  end
end
