import React from 'react'

import { SpotifyPlaylistSelectionView } from './'
import { jsonTo, serializedAccount, serializedSpotifyPlaylist } from '../../../types'
import Hoc, { HocPropsType } from '../../../common/Hoc'

type SpotifyPlaylistSelectionViewHocProps = {
  playlists: string;
  account: string;
} & HocPropsType

const SpotifyPlaylistSelectionViewHoc = (props: SpotifyPlaylistSelectionViewHocProps) => {
  const playlists: serializedSpotifyPlaylist[] = jsonTo<serializedSpotifyPlaylist[]>(props.playlists)
  const account: serializedAccount = jsonTo<serializedAccount>(props.account)

  return (
    <Hoc {...props}>
      <SpotifyPlaylistSelectionView account={account} playlists={playlists} />
    </Hoc>
  )
}

export default SpotifyPlaylistSelectionViewHoc
