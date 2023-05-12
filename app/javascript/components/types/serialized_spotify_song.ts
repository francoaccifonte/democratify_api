export interface serialized_spotify_song {
  id: Number;
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
}
