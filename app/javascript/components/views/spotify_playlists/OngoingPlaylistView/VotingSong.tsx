import React from 'react'
import { serializedVotationCandidate } from '../../../types'
import withStyles from 'react-jss'
import { adminPalette } from '../../../ColorPalette'
import { Image } from 'react-bootstrap'
import { Text } from '../../../common'

type PropTypes = {
  song: serializedVotationCandidate;
  totalVotes: number;
  classes: any
}
const VotingSong: React.FC<PropTypes> = (props) => {
  const { classes, song, totalVotes } = props
  const percent = String(Math.floor(100 * song.votes / totalVotes))

  return (
    <div className={classes.container}>
      <Image className={classes.image} src={song.spotify_song.cover_art[2].url} alt="album art" roundedCircle/>
      <div className={ classes.textBlock }>
        <Text type="bodyRegular" color="White" className={classes.textItem}>{song.spotify_song.title}</Text>
        <Text type="bodyCaption" color="White" className={classes.textItem}>{song.spotify_song.artist}</Text>
      </div>
      <Text type="bodyRegular" className={classes.percent}>{percent}%</Text>
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
      backgroundColor: theme.Muted
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
    percent: {
      color: theme.White,
      fontSize: '20px',
      marginLeft: 'auto',
      marginRight: '20px'
    },
  }
}

export default withStyles(styles)(VotingSong)
