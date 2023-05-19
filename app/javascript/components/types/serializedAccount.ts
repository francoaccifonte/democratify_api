import { serializedSpotifyUser } from '.'

export interface serializedAccount {
  id: number;
  email?: String;
  name?: String;
  token?: String;
  created_at: Date;
  updated_at: Date;
  spotify_user?: serializedSpotifyUser
}
