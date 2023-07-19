# == Schema Information
#
# Table name: spotify_users
#
#  id                       :bigint           not null, primary key
#  access_token             :string
#  access_token_expires_at  :datetime
#  email                    :string
#  href                     :string
#  name                     :string
#  refresh_token            :string
#  refresh_token_expires_at :datetime
#  scope                    :string
#  uri                      :string
#  user_provided_email      :string           not null
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  account_id               :bigint
#  spotify_id               :string
#
# Indexes
#
#  index_spotify_users_on_account_id  (account_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#
require 'rails_helper'

RSpec.describe SpotifyUser do
  describe '#access_token_expired?' do
    context 'when token is expired' do
      it 'returns true' do
        freeze_time do
          user = create(:spotify_user, access_token_expires_at: 10.hours.ago)
          expect(user.access_token_expired?).to be(true)
        end
      end
    end

    context 'when token is not expired' do
      it 'returns false' do
        freeze_time do
          user = create(:spotify_user, access_token_expires_at: 10.hours.from_now)
          expect(user.access_token_expired?).to be(false)
        end
      end
    end

    context 'when token is about to expire' do
      it 'returns true' do
        freeze_time do
          user = create(:spotify_user, access_token_expires_at: 4.minutes.from_now)
          expect(user.access_token_expired?).to be(true)
        end
      end
    end
  end
end
