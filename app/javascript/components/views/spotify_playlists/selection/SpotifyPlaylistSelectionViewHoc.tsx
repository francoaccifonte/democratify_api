import React from 'react'
import withStyles, { ThemeProvider } from 'react-jss'

import { adminPalette } from '../../../ColorPalette'
import { SpotifyPlaylistSelectionView } from './'
import { jsonTo, serializedAccount, serialized_spotify_playlist } from '../../../types'

type SpotifyPlaylistSelectionViewHocProps = {
  playlists: string;
  account: string;
}

const SpotifyPlaylistSelectionViewHoc = (props: SpotifyPlaylistSelectionViewHocProps) => {
  const account: serializedAccount = jsonTo<serializedAccount>(props.account)
  const playlists: serialized_spotify_playlist[] = jsonTo<serialized_spotify_playlist[]>(props.playlists)

  return (
    <ThemeProvider theme={adminPalette}>
      <SpotifyPlaylistSelectionView account={account} playlists={playlists} />
    </ThemeProvider>
  )
}

export default SpotifyPlaylistSelectionViewHoc
