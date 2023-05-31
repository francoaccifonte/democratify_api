import { serializedAccount, serializedSpotifyPlaylist, serializedSpotifySong } from '.'

export interface serializedOngoingPlaylist {
  id: number;
  pool_size: number;
  created_at: Date;
  updated_at: Date;

  account: serializedAccount;
  spotify_playlist: serializedSpotifyPlaylist;
  playing_song: serializedSpotifySong
  voting_songs: serializedSpotifySong[];
  remaining_songs: serializedSpotifySong[];
}
