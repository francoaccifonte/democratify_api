# == Schema Information
#
# Table name: spotify_users
#
#  id                       :bigint           not null, primary key
#  access_token             :string
#  access_token_expires_at  :datetime
#  email                    :string
#  href                     :string           not null
#  name                     :string
#  refresh_token            :string
#  refresh_token_expires_at :datetime
#  scope                    :string           not null
#  uri                      :string
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  account_id               :bigint
#  spotify_id               :string           not null
#
# Indexes
#
#  index_spotify_users_on_account_id  (account_id)
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#
require 'rails_helper'

RSpec.describe SpotifyUser, type: :model do
  include_context 'with mocked spotify client'

  context 'when a user is created' do
    before { mock_user }

    subject { create(:spotify_user) }

    it 'enqueues an import job' do
      subject
      expect(PlaylistImportWorker.jobs.size).to eq(1)
    end
  end

  context 'when token is expired' do
    before { mock_user }

    subject { create(:spotify_user, access_token_expires_at: Time.zone.now - 1.days) }

    it 'refreshes the token' do
      
    end
  end
end
