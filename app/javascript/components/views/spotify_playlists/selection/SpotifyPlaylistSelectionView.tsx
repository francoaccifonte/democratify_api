import React from 'react'

import { EmptyState, ImportInProgress, List } from './'
import { FullHeightSkeleton } from '../../../common'
import { serializedAccount, serializedSpotifyPlaylist } from '../../../types'
import { adminPalette } from '../../../ColorPalette'
import withStyles from 'react-jss'

type SpotifyPlaylistSelectionViewProps = {
  playlists: serializedSpotifyPlaylist[],
  account: serializedAccount,
  importInProgress: boolean,
  classes: any
}

const SpotifyPlaylistSelectionView = (props: SpotifyPlaylistSelectionViewProps) => {
  return (
    <FullHeightSkeleton header footer palette='admin'>
      <div className={props.classes.container}>
        {
          props.playlists.length > 0
            ? <List playlists={props.playlists}/>
            : !props.importInProgress ? <EmptyState {...props} /> : null
        }
        {
          props.importInProgress && <ImportInProgress />
        }
      </div>
    </FullHeightSkeleton>
  )
}

const styles = (theme: typeof adminPalette) => {
  return {
    container: {
      display: 'flex',
      flexDirection: 'column'
    }
  }
}

export default withStyles(styles)(SpotifyPlaylistSelectionView)
