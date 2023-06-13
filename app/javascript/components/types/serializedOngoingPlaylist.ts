import { serializedAccount, serializedSpotifyPlaylist, serializedSpotifyPlaylistSong } from '.'

export interface serializedOngoingPlaylist {
  id: number;
  pool_size: number;
  created_at: Date;
  updated_at: Date;

  account: serializedAccount;
  spotify_playlist: serializedSpotifyPlaylist;
  playing_song: serializedSpotifyPlaylistSong
  voting_songs: serializedSpotifyPlaylistSong[];
  remaining_songs: serializedSpotifyPlaylistSong[];
}
