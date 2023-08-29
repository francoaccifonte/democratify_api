
import React from 'react'
import Image from 'react-bootstrap/Image'
import { serializedSpotifySong } from '../../../types'
import { Text } from '../../../common'
import { adminPalette } from '../../../ColorPalette'
import withStyles from 'react-jss'

type PlayingSongProps = {
  song?: serializedSpotifySong;
  classes: any
}

const PlayingSong = (props: PlayingSongProps) => {
  const { classes, song } = props

  if (!song) { return null }

  return (
    <div className={classes.container}>
      <Image className={classes.image} src={song.cover_art[2].url} alt="album art" roundedCircle/>
        <div className={classes.textBlock }>
          <Text type="bodyRegular" color="White" className={classes.textItem}>{song.title}</Text>
          <Text type="bodyCaption" color="White" className={classes.textItem}>{song.artist}</Text>
        </div>
    </div>
  )
}

const styles = (theme: typeof adminPalette) => {
  return {
    container: {
      marginTop: '0.5rem',
      marginBottom: '0.5rem',
      marginRight: '-12px',
      marginLeft: '-12px',
      display: 'flex',
      flexDirection: 'row',
      alignItems: 'center',
      backgroundColor: theme.Primary
    },
    textBlock: {
      display: 'flex',
      flexDirection: 'column',
      marginRight: '20px',
      overflow: 'hidden',
      whiteSpace: 'nowrap',
    },
    textItem: {
      textAlign: 'left',
      overflow: 'hidden',
      textOverflow: 'ellipsis',
    },
    image: {
      width: '64px',
      height: '64px',
      marginTop: '10px',
      marginBottom: '10px',
      marginRight: '20px',
      marginLeft: '20px',
    },
  }
}

export default withStyles(styles)(PlayingSong)
