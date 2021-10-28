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

  account.integrations.create!(provider: 'spotify',
                               token: 'aaaa',
                               uuid: '34fFs29kd09')
end
