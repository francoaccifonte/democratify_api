# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

def songs_params(size = 50)
  size.times.map do
    {
      title: Faker::Music::RockBand.song,
      artist: Faker::Music::RockBand.name,
      album: Faker::Music::RockBand.name
    }
  end
end

ActiveRecord::Base.transaction do
  account = Account.create(name: 'admin', email: 'admin@democratify.com')
  account.playlists.create!(description: 'odins favourites', name: 'Valhala', provider: 'spotify')
         .songs.create!(songs_params)

  main_token = Account.first.integrations.create!(
    provider: 'spotify',
    token: 'aaaa',
    uuid: '34fFs29kd09',
    type_in_chain: 'front_end_token'
  )

  refresh_token = Integration.create!(
    front_end_token: main_token,
    token: 'aaaa',
    type_in_chain: 'refresh_token',
    expires_at: Time.now + 3600.second
  )

  Integration.create!(
    refresh_token: refresh_token,
    token: 'aaaa',
    type_in_chain: 'active_token',
    expires_at: Time.now + 3600.second
  )
end
