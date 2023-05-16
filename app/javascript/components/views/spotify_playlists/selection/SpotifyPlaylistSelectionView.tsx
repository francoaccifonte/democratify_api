import React from 'react'

import { List } from './index'
import { FullHeightSkeleton } from '../../../common'
import { serializedAccount, serializedSpotifyPlaylist } from '../../../types'

type SpotifyPlaylistSelectionViewProps = {
  playlists: serializedSpotifyPlaylist[],
  account: serializedAccount
}

const SpotifyPlaylistSelectionView = (props: SpotifyPlaylistSelectionViewProps) => {
  return (
    <FullHeightSkeleton header footer palette='admin'>
      <List playlists={props.playlists}/>
    </FullHeightSkeleton>
  )
}

export default SpotifyPlaylistSelectionView
