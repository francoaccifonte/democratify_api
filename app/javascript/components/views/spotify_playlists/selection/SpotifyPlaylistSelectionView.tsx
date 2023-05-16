import React from 'react'

import { List } from './index'
import { FullHeightSkeleton } from '../../../common'
import { serializedAccount, serialized_spotify_playlist } from '../../../types'

type SpotifyPlaylistSelectionViewProps = {
  playlists: serialized_spotify_playlist[],
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
