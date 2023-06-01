/* eslint-disable camelcase */
import { faker } from '@faker-js/faker'
import { serializedSpotifyPlaylist, serializedSpotifySong } from '../../../app/javascript/components/types'
import { serialized_spotify_song_fixture } from './'

export const serialized_spotify_playlist_fixture = (
  spotify_songs: serializedSpotifySong[] = serialized_spotify_song_fixture()
): serializedSpotifyPlaylist => {
  return {
    id: faker.number.int({ min: 10000000 }),
    name: faker.company.name(),
    description: faker.lorem.sentence(),
    external_url: faker.internet.url(),
    cover_art_url: faker.internet.url(),
    created_at: new Date(),
    updated_at: new Date(),
    spotify_songs,
  }
}
