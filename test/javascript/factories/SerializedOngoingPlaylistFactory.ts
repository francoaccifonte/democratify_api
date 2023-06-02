/* eslint-disable camelcase */
import { faker } from '@faker-js/faker'
import { serializedOngoingPlaylist } from '../../../app/javascript/components/types'
import { SerializedAccountFactory, SerializedSpotifyPlaylistFactory } from './'

type serializedOngoingPlaylistFactoryParams = Partial<serializedOngoingPlaylist>

export const serializedOngoingPlaylistFactory = (params: serializedOngoingPlaylistFactoryParams = {}): serializedOngoingPlaylist => {
  const pool_size = params.pool_size || 3
  const spotify_playlist = params.spotify_playlist || SerializedSpotifyPlaylistFactory({})

  const fakedParams: serializedOngoingPlaylist = {
    id: params.id || faker.number.int({ min: 10000000 }),
    pool_size,
    account: params.account || SerializedAccountFactory({}),
    spotify_playlist,
    playing_song: params.playing_song || spotify_playlist.spotify_songs[0],
    voting_songs: params.voting_songs || spotify_playlist.spotify_songs.slice(1, pool_size),
    remaining_songs: params.remaining_songs || spotify_playlist.spotify_songs.slice(pool_size + 1),
    created_at: params.created_at || new Date(),
    updated_at: params.updated_at || new Date(),
  }
  return { ...fakedParams }
}
