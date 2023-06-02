/* eslint-disable camelcase */
import { faker } from '@faker-js/faker'
import { serializedSpotifySong } from '../../../app/javascript/components/types'

type SerializedSpotifySongFactoryParams = Partial<serializedSpotifySong>

export const SerializedSpotifySongFactory = (params:SerializedSpotifySongFactoryParams = {}): serializedSpotifySong => {
  const fakedParams = {
    id: params.id || faker.number.int({ min: 10000000 }),
    title: params.title || faker.music.songName(),
    artist: params.artist || faker.company.name(),
    album: params.album || faker.company.name(),
    year: params.year || faker.number.int({ min: 1970, max: 2023 }),
    genre: params.genre || faker.music.genre(),
    external_id: params.external_id || faker.string.uuid(),
    uri: params.uri || faker.internet.url(),
    metadata: params.metadata || {},
    duration: params.duration || faker.number.float(),
    created_at: params.created_at || new Date(),
    updated_at: params.updated_at || new Date(),
    cover_art: params.cover_art || [
      { url: faker.internet.url(), width: 640, height: 640 },
      { url: faker.internet.url(), width: 300, height: 300 },
      { url: faker.internet.url(), width: 64, height: 64 }
    ],
  }

  return { ...fakedParams }
}
