export interface serialized_spotify_song {
  id: Number;
  uri: string;
  album?: string;
  artist: string;
  cover_art?: string; // It's actually a jsonb
  duration?: number;
  genre?: string;
  metadata?: string; // It's actually a jsonb
  title: string;
  year?: number;
  external_id: string;
  created_at: Date;
  updated_at: Date;
}
