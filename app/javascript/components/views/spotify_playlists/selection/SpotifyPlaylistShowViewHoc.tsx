import React from 'react'
import withStyles, { ThemeProvider } from 'react-jss'

import { adminPalette } from '../../../ColorPalette'
import { SpotifyPlaylistShowView } from './'
import { json_to, serialized_account, serialized_spotify_playlist } from '../../../types'

type SpotifyPlaylistShowViewHocProps = {
  playlist: string;
  account: string;
}

const SpotifyPlaylistShowViewHoc = (props: SpotifyPlaylistShowViewHocProps) => {
  const account: serialized_account = json_to<serialized_account>(props.account)
  const playlist: serialized_spotify_playlist = json_to<serialized_spotify_playlist>(props.playlist)

  return (
    <ThemeProvider theme={adminPalette}>
      <SpotifyPlaylistShowView account={account} playlist={playlist} />
    </ThemeProvider>
  )
}

export default SpotifyPlaylistShowViewHoc
