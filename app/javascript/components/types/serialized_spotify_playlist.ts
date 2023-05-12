import { serialized_spotify_song } from "./";

export interface serialized_spotify_playlist {
  id: Number;
  description: string;
  name: string;
  external_url: string;
  cover_art_url: string;
  created_at: Date;
  updated_at: Date;
  sample_songs: serialized_spotify_song[];
  spotify_songs: serialized_spotify_song[];
}
