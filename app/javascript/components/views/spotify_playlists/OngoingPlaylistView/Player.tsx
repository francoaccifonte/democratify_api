import React from 'react'
import withStyles from 'react-jss'

import { PlaylistCard } from '../selection'
import { Text } from '../../../common'
import { serializedOngoingPlaylist } from '../../../types'

type PlayerProps = {
  classes?: any;
  ongoingPlaylist: serializedOngoingPlaylist;
  poolControls: any;
}

const Player:React.FC<PlayerProps> = (props) => {
  const { ongoingPlaylist, poolControls } = props
  const candidatePoolSize = ongoingPlaylist.pool_size

  return (
    <div className={props.classes.container}>
      <PlaylistCard playlist={ongoingPlaylist.spotify_playlist}
      />

      <Text type='bodyRegular' color='White'>Canciones por votación</Text>
      <div className={props.classes.poolSizeContainer}>
        <div className={props.classes.poolSizeLeft} onClick={poolControls.decrementPoolSize}>-</div>
        <div className={props.classes.poolSizeLabel}>
          <Text type='bodyRegular' color='Black'>{candidatePoolSize}</Text>
        </div>
        <div className={props.classes.poolSizeRight} onClick={poolControls.decrementPoolSize}>+</div>
      </div>
    </div>
  )
}

const styles = (theme: any) => {
  return {
    container: {
      display: 'flex',
      flexDirection: 'column',
      alignItems: 'center'
    },
    poolSizeContainer: {
      display: 'flex',
      flexDirection: 'row',
      alignItems: 'center',
      textAlign: 'center',
      height: '2rem',
      composes: 'mt-3'
    },
    poolSizeButton: {
      backgroundColor: theme.Muted,
      borderColor: theme.Muted,
      height: '100%',
      width: '2.35rem',
      color: theme.White,
      '&:hover': {
        cursor: 'pointer'
      }
    },
    poolSizeLeft: {
      composes: '$poolSizeButton',
      borderRadius: '0.75rem 0px 0px 0.75rem'
    },
    poolSizeRight: {
      composes: '$poolSizeButton',
      borderRadius: '0px 0.75rem 0.75rem 0px'
    },
    poolSizeLabel: {
      backgroundColor: theme.Info,
      width: '3.75rem',
      height: '100%'
    }
  }
}

export default withStyles(styles)(Player)
