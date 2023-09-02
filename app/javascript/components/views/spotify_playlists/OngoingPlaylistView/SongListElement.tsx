import React from 'react'
import Image from 'react-bootstrap/Image'

import { serializedSpotifySong } from '../../../types'
import { Text } from '../../../common'
import { adminPalette } from '../../../ColorPalette'
import withStyles from 'react-jss'
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome'

type songListProps = {
  rowNumber: number;
  data: serializedSpotifySong;
  poolSize: number;
  classes: any;
}

const SongListElement: React.FC<songListProps> = ({ rowNumber, data, poolSize, classes }): JSX.Element => {
  const color = rowNumber < poolSize ? adminPalette.Success : adminPalette.Secondary

  return (
    <div className={classes.container} style={{ backgroundColor: color }}>
      <Image className={classes.image} src={data.cover_art[2].url} alt="album art" roundedCircle/>
        <div className={classes.textBlock}>
          <Text type="bodyRegular" color="White" className={classes.textItem}>{data.title}</Text>
          <Text type="bodyCaption" color="White" className={classes.textItem}>{data.artist}</Text>
        </div>
      <FontAwesomeIcon icon={['fas', 'grip-lines']} className={classes.grabber} />
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
    grabber: {
      color: theme.White,
      fontSize: '20px',
      marginLeft: 'auto',
      marginRight: '20px'
    },
  }
}

export default withStyles(styles)(SongListElement)
