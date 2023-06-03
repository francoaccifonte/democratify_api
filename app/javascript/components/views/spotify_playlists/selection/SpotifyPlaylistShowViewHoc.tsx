import React from 'react'

import Hoc, { HocPropsType } from '../../../common/Hoc'
import { SpotifyPlaylistShowView } from './'
import { jsonTo, serializedAccount, serializedSpotifyPlaylist } from '../../../types'

type SpotifyPlaylistShowViewHocProps = {
  playlist: string;
  account: string;
} & HocPropsType

const SpotifyPlaylistShowViewHoc: React.FC<SpotifyPlaylistShowViewHocProps> = (props): JSX.Element => {
  const account: serializedAccount = jsonTo<serializedAccount>(props.account)
  const playlist: serializedSpotifyPlaylist = jsonTo<serializedSpotifyPlaylist>(props.playlist)

  return (
    <Hoc {...props}>
      <SpotifyPlaylistShowView account={account} playlist={playlist} />
    </Hoc>
  )
}

export default SpotifyPlaylistShowViewHoc
