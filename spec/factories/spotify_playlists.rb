# == Schema Information
#
# Table name: spotify_playlists
#
#  id              :bigint           not null, primary key
#  cover_art_url   :string
#  description     :string
#  external_url    :string
#  name            :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  account_id      :bigint
#  external_id     :string
#  spotify_user_id :bigint           not null
#
# Indexes
#
#  index_spotify_playlists_on_account_id       (account_id)
#  index_spotify_playlists_on_external_id      (external_id)
#  index_spotify_playlists_on_spotify_user_id  (spotify_user_id)
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#  fk_rails_...  (spotify_user_id => spotify_users.id)
#
FactoryBot.define do
  factory :spotify_playlist do
    cover_art_url { Faker::Internet.url }
    description { Faker::Lorem.paragraph }
    external_url { Faker::Internet.url }
    name { Faker::Music.genre }
    external_id { Faker::Number.number(digits: 10).to_s }

    association :account, factory: :account
    association :spotify_user, factory: :spotify_user
  end
end
