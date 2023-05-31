export interface serializedVotationCandidate {
  id: number;
  votes: number;
  created_at: Date;
  updated_at: Date;
  account_id: number;
  ongoing_playlist_id: number;
  spotify_playlist_song_id: number;
  votation_id: number;

  spotify_song: serializedVotationCandidate;
}
