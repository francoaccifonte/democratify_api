import { serialized_spotify_playlist } from "../../../app/javascript/components/types";

export const serialized_spotify_playlist_fixture = (): serialized_spotify_playlist => {
 return {
  id: 12,
  name: "Hot Club Swing",
  description: "Django and beyond.",
  external_url: null,
  cover_art_url: "https://i.scdn.co/image/ab67706f0000000348d1bd1f3191f46ffea218a7",
  created_at: new Date(),
  updated_at: new Date(),
  spotify_songs: [],
 }
}
