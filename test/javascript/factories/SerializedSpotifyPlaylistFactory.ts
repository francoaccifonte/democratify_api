/* eslint-disable camelcase */
import { faker } from '@faker-js/faker'
import { serializedSpotifyPlaylist } from '../../../app/javascript/components/types'
import { SerializedSpotifySongFactory, buildList } from '.'

type SerializedSpotifyPlaylistFactoryParams = Partial<serializedSpotifyPlaylist>

export const SerializedSpotifyPlaylistFactory = (params: SerializedSpotifyPlaylistFactoryParams = {}): serializedSpotifyPlaylist => {
  const fakedParams = {
    id: params.id || faker.number.int({ min: 10000000 }),
    name: params.name || faker.company.name(),
    description: params.description || faker.lorem.sentence(),
    external_url: params.external_url || faker.internet.url(),
    cover_art_url: params.cover_art_url || faker.internet.url(),
    created_at: params.created_at || new Date(),
    updated_at: params.updated_at || new Date(),
    spotify_songs: params.spotify_songs || buildList(SerializedSpotifySongFactory, 10)
  }

  return { ...fakedParams }
}
