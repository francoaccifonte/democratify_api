# frozen_string_literal: true

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
#  whitelisted              :boolean          default(FALSE)
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
class SpotifyUserSerializer < Panko::Serializer
  attributes :id, :email, :created_at, :updated_at, :user_provided_email, :account_id, :whitelisted
end
