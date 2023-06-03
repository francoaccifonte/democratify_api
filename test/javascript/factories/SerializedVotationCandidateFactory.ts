/* eslint-disable camelcase */
import { faker } from '@faker-js/faker'
import { serializedVotationCandidate } from '../../../app/javascript/components/types'
import { SerializedSpotifySongFactory } from './SerializedSpotifySongFactory'

type serializedVotationCandidateFactoryParams = Partial<serializedVotationCandidate>;

export const serializedVotationCandidateFactory = (params: serializedVotationCandidateFactoryParams = {}): serializedVotationCandidate => {
  const fakedParams: serializedVotationCandidate = {
    id: params.id || faker.number.int({ min: 10000000 }),
    votes: params.votes || faker.number.int({ min: 1, max: 5 }),
    created_at: params.created_at || new Date(),
    updated_at: params.updated_at || new Date(),
    account_id: params.account_id || faker.number.int({ min: 10000000 }),
    ongoing_playlist_id: params.ongoing_playlist_id || faker.number.int({ min: 10000000 }),
    spotify_playlist_song_id: params.spotify_playlist_song_id || faker.number.int({ min: 10000000 }),
    votation_id: params.votation_id || faker.number.int({ min: 10000000 }),
    spotify_song: params.spotify_song || SerializedSpotifySongFactory()
  }

  return { ...fakedParams }
}
