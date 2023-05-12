import React from 'react'
import withStyles, { ThemeProvider } from 'react-jss'

import { adminPalette } from '../../../ColorPalette'
import { SpotifyPlaylistSelectionView } from './'
import { json_to, serialized_account, serialized_spotify_playlist } from '../../../types'

type SpotifyPlaylistSelectionViewHocProps = {
  playlists: string;
  account: string;
}

const SpotifyPlaylistSelectionViewHoc = (props: SpotifyPlaylistSelectionViewHocProps) => {
  const account: serialized_account = json_to<serialized_account>(props.account)
  const playlists: serialized_spotify_playlist[] = json_to<serialized_spotify_playlist[]>(props.playlists)

  return (
    <ThemeProvider theme={adminPalette}>
      <SpotifyPlaylistSelectionView account={account} playlists={playlists} />
    </ThemeProvider>
  )
}

export default SpotifyPlaylistSelectionViewHoc
