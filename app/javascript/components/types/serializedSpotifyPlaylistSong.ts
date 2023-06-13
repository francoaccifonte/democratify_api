export interface serializedSpotifyPlaylistSong {
  id: number;
  uri: string;
  album?: string;
  artist: string;
  cover_art?: {
    url: string;
    width: number;
    height: number;
  }[];
  duration?: number;
  genre?: string;
  metadata?: object;
  title: string;
  year?: number;
  external_id: string;
  created_at: Date;
  updated_at: Date;
  index: number;
  spotify_playlist_id: number;
  spotify_song_id: number;
  enqueued_at: Date
}
