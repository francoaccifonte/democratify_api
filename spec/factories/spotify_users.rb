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
FactoryBot.define do
  factory :spotify_user do
    access_token { Faker::Lorem.characters(number: 50) }
    access_token_expires_at { Time.zone.now + 30.minutes }
    email { Faker::Internet.email }
    href { Faker::Internet.url }
    name { Faker::Name.name }
    refresh_token { Faker::Lorem.characters(number: 50) }
    scope { 'playlist-read-private playlist-read-collaborative user-modify-playback-state user-read-playback-state user-read-currently-playing user-read-email'}
    uri { Faker::Internet.url }
    spotify_id { Faker::Number.number(digits: 10).to_s }

    association :account, factory: :account
    # association :spotify_playlists, factory: :spotify_playlists

    trait :expired_token do
      access_token_expires_at { 1.day.ago }
    end
  end
end
