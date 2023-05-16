import { serializedSpotifySong } from '.'

export interface serializedSpotifyPlaylist {
  id: number;
  description: string;
  name: string;
  external_url: string;
  cover_art_url: string;
  created_at: Date;
  updated_at: Date;
  spotify_songs: serializedSpotifySong[];
}
