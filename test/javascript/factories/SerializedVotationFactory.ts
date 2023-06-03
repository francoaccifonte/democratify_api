/* eslint-disable camelcase */
import { faker } from '@faker-js/faker'
import { serializedVotation } from '../../../app/javascript/components/types'
import { buildList } from './helpers'
import { serializedVotationCandidateFactory } from './SerializedVotationCandidateFactory'

type SerializedAccountFactoryParams = Partial<serializedVotation>;

export const serializedVotationFactory = (params: SerializedAccountFactoryParams = {}): serializedVotation => {
  const fakedParams: serializedVotation = {
    id: params.id || faker.number.int({ min: 10000000 }),
    in_progress: params.in_progress || true,
    queued: params.queued || false,
    scheduled_close_for: params.scheduled_close_for || new Date(),
    scheduled_end_at: params.scheduled_end_at || new Date(),
    scheduled_end_for: params.scheduled_end_for || new Date(),
    scheduled_start_at: params.scheduled_start_at || new Date(),
    scheduled_start_for: params.scheduled_start_for || new Date(),
    started_at: params.started_at || new Date(),
    created_at: params.created_at || new Date(),
    updated_at: params.updated_at || new Date(),
    account_id: params.account_id || faker.number.int({ min: 10000000 }),
    ongoing_playlist_id: params.ongoing_playlist_id || faker.number.int({ min: 10000000 }),
    votation_candidates: params.votation_candidates || buildList(serializedVotationCandidateFactory, 2)
  }

  return { ...fakedParams }
}
