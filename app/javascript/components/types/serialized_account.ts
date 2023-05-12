import { serialized_spotify_user } from "./";

export interface serialized_account {
  id: number;
  email?: String;
  name?: String;
  token?: String;
  created_at: Date;
  updated_at: Date;
  spotify_users?: serialized_spotify_user[]
}
