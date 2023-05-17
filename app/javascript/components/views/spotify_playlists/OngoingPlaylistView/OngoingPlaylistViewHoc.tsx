import React from 'react'
import { ThemeProvider } from 'react-jss'
import { adminPalette } from '../../../ColorPalette'

import { jsonTo, serializedAccount, serializedSpotifyPlaylist, serializedOngoingPlaylist, serializedVotation } from '../../../types'
import { OngoingPlaylistView } from './'

type OngoingPlaylistViewHocProps = {
  playlist: string;
  account: string;
  ongoingPlaylist: string;
  votation: string;
}

const OngoingPlaylistViewHoc: React.FC<OngoingPlaylistViewHocProps> = (props) => {
  const account: serializedAccount = jsonTo<serializedAccount>(props.account)
  const playlist: serializedSpotifyPlaylist = jsonTo<serializedSpotifyPlaylist>(props.playlist)
  const ongoingPlaylist: serializedOngoingPlaylist = jsonTo<serializedOngoingPlaylist>(props.ongoingPlaylist)
  const votation: serializedVotation = jsonTo<serializedVotation>(props.votation)

  return (
    <ThemeProvider theme={adminPalette}>
      <OngoingPlaylistView account={account} playlist={playlist} ongoingPlaylist={ongoingPlaylist} votation={votation}/>
    </ThemeProvider>
  )
}

export default OngoingPlaylistViewHoc
