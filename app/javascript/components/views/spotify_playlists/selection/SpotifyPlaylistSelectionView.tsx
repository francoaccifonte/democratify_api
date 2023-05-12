import React from 'react'

import { List } from './index'
import { FullHeightSkeleton } from '../../../common'
import { serialized_account, serialized_spotify_playlist } from '../../../types'

type SpotifyPlaylistSelectionViewProps = {
  playlists: serialized_spotify_playlist[],
  account: serialized_account
}

const SpotifyPlaylistSelectionView = (props: SpotifyPlaylistSelectionViewProps) => {
  return (
    <FullHeightSkeleton header footer palette='admin'>
      <List playlists={props.playlists}/>
    </FullHeightSkeleton>
  )
}

export default SpotifyPlaylistSelectionView
