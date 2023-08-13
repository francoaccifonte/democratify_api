export interface serializedSpotifyUser {
  id: number;
  email?: String;
  user_provided_email?: String;
  whitelisted: Boolean;
  created_at: Date;
  updated_at: Date;
}
