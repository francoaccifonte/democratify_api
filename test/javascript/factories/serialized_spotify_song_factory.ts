import { faker } from '@faker-js/faker'
import { serialized_spotify_song } from '../../../app/javascript/components/types'

export const serialized_spotify_song_fixture = (): serialized_spotify_song => {
  return {
    id: faker.number.int({ min: 10000000 }),
    title: faker.music.songName(),
    artist: faker.company.name(),
    album: faker.company.name(),
    year: faker.number.int({ min: 1970, max: 2023 }),
    genre: faker.music.genre(),
    external_id: faker.string.uuid(),
    uri: faker.internet.url(),
    metadata: {},
    duration: faker.number.float(),
    cover_art: [
      { url: faker.internet.url(), width: 640, height: 640 },
      { url: faker.internet.url(), width: 300, height: 300 },
      { url: faker.internet.url(), width: 64, height: 64 }
    ],
    created_at: new Date(),
    updated_at: new Date(),
  }
}
