import { serializedVotationCandidate } from '.'

export interface serializedVotation {
  id: number;
  in_progress: boolean;
  queued: boolean;
  scheduled_close_for: Date;
  scheduled_end_at: Date;
  scheduled_end_for: Date;
  scheduled_start_at: Date;
  scheduled_start_for: Date;
  started_at: Date;
  created_at: Date;
  updated_at: Date;
  account_id: number;
  ongoing_playlist_id: number;

  votation_candidates: serializedVotationCandidate[];
}
