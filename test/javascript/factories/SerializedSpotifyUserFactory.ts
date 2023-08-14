/* eslint-disable camelcase */
import { faker } from '@faker-js/faker'
import { serializedSpotifyUser } from '../../../app/javascript/components/types'

type SerializedSpotifyUserFactoryParams = Partial<serializedSpotifyUser>;

export const SerializedSpotifyUserFactory = (params: SerializedSpotifyUserFactoryParams = {}): serializedSpotifyUser => {
  const fakedParams: serializedSpotifyUser = {
    id: params.id || faker.number.int({ min: 10000000 }),
    email: params.email || faker.internet.email(),
    user_provided_email: params.user_provided_email || faker.internet.email(),
    created_at: params.created_at || new Date(),
    updated_at: params.updated_at || new Date(),
  }

  return { ...fakedParams }
}
