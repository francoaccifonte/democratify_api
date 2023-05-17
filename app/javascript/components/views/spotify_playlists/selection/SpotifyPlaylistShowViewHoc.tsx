import React from 'react'
import { ThemeProvider } from 'react-jss'

import { adminPalette } from '../../../ColorPalette'
import { SpotifyPlaylistShowView } from './'
import { jsonTo, serializedAccount, serializedSpotifyPlaylist } from '../../../types'

type SpotifyPlaylistShowViewHocProps = {
  playlist: string;
  account: string;
}

const SpotifyPlaylistShowViewHoc: React.FC<SpotifyPlaylistShowViewHocProps> = (props) => {
  const account: serializedAccount = jsonTo<serializedAccount>(props.account)
  const playlist: serializedSpotifyPlaylist = jsonTo<serializedSpotifyPlaylist>(props.playlist)

  return (
    <ThemeProvider theme={adminPalette}>
      <SpotifyPlaylistShowView account={account} playlist={playlist} />
    </ThemeProvider>
  )
}

export default SpotifyPlaylistShowViewHoc
