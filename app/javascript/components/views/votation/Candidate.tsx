import React from 'react'
import Image from 'react-bootstrap/Image'
import classNames from 'classnames'

import { serializedVotationCandidate } from '../../types'
import { Text } from '../../common'
import { userPalette } from '../../ColorPalette'
import withStyles from 'react-jss'

type CandidateElementProps = {
  classes?: any
  data: serializedVotationCandidate,
  key?: number,
  onSelect?: Function,
  isSelected?: boolean,
  disabled?: boolean,
};

const BetterCandidate = (props: CandidateElementProps) => {
  const className = props.isSelected ? classNames(props.classes.container, props.classes.selectedRow) : classNames(props.classes.container, props.classes.otherRows)
  return (
    <div className={className}>
      <Image src={props.data.spotify_song?.cover_art[1].url} style={{ maxWidth: '5rem', maxHeight: '5rem' }}/>
      <div className={props.classes.description}>
        <Text type="bodyImportant" color="black">{props.data.spotify_song?.title}</Text>
        <Text type="bodyImportant" color="black" style={{ fontSize: '1rem', lineSize: '1rem' }}>{props.data.spotify_song?.artist}</Text>
      </div>
    </div>
  )
}

const styles = (palette: typeof userPalette) => {
  return {
    container: {
      display: 'flex',
      padding: '1.5rem',
      backgroundColor: palette.Black,
      borderRadius: '0.75rem',
      justifyContent: 'space-between'
    },
    selectedRow: {
      backgroundColor: palette.Success,
      textAlign: 'right'
    },
    otherRows: {
      backgroundColor: palette.Info,
      textAlign: 'right'
    },
    description: {
      display: 'flex',
      flexDirection: 'column',
    }
  }
}

export default withStyles(styles)(BetterCandidate)
