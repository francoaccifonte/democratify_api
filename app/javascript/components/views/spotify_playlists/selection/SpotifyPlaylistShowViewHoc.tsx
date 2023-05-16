import React from 'react'
import { ThemeProvider } from 'react-jss'

import { adminPalette } from '../../../ColorPalette'
import { SpotifyPlaylistShowView } from './'
import { jsonTo, serializedAccount, serialized_spotify_playlist } from '../../../types'

type SpotifyPlaylistShowViewHocProps = {
  playlist: string;
  account: string;
}

const SpotifyPlaylistShowViewHoc = (props: SpotifyPlaylistShowViewHocProps) => {
  const account: serializedAccount = jsonTo<serializedAccount>(props.account)
  const playlist: serialized_spotify_playlist = jsonTo<serialized_spotify_playlist>(props.playlist)

  return (
    <ThemeProvider theme={adminPalette}>
      <SpotifyPlaylistShowView account={account} playlist={playlist} />
    </ThemeProvider>
  )
}

export default SpotifyPlaylistShowViewHoc
