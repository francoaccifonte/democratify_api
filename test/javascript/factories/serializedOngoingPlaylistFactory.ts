/* eslint-disable camelcase */
import { faker } from '@faker-js/faker'
import { serializedAccount, serializedOngoingPlaylist, serializedSpotifyPlaylist } from '../../../app/javascript/components/types'
import { serialized_account_fixture, serialized_spotify_playlist_fixture } from './'

export const serializedOngoingPlaylistFactory = (
  account: serializedAccount = serialized_account_fixture(),
  spotify_playlist: serializedSpotifyPlaylist = serialized_spotify_playlist_fixture(),
  pool_size = 3
): serializedOngoingPlaylist => {
  return {
    id: faker.number.int({ min: 10000000 }),
    pool_size,
    account,
    spotify_playlist,
    playing_song: spotify_playlist.spotify_songs[0],
    voting_songs: spotify_playlist.spotify_songs.slice(1, pool_size),
    remaining_songs: spotify_playlist.spotify_songs.slice(pool_size + 1),

    created_at: new Date(),
    updated_at: new Date(),
  }
}
