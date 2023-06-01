import { faker } from '@faker-js/faker'
import { serializedSpotifyPlaylist } from '../../../app/javascript/components/types'

export const SerializedSpotifyPlaylistFactory = (): serializedSpotifyPlaylist => {
  return {
    id: faker.number.int({ min: 10000000 }),
    name: faker.company.name(),
    description: faker.lorem.sentence(),
    external_url: faker.internet.url(),
    cover_art_url: faker.internet.url(),
    created_at: new Date(),
    updated_at: new Date(),
    spotify_songs: [],
  }
}
