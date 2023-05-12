import React from 'react'
import Card from 'react-bootstrap/Card'
import withStyles, { WithStylesProps } from 'react-jss'

import { Text } from '../../../common'
import { serialized_spotify_playlist } from '../../../types'
import { adminPalette } from '../../../ColorPalette'

type PlaylistCardProps = {
  classes: any;
  playlist: serialized_spotify_playlist;
}

const PlaylistCard = (props: PlaylistCardProps) => {
  const { playlist } = props;
  const href = `/playlists/${playlist.id}`
  return (
    <Card className={`mb-3 mt-3 ${props.classes.card}`}>
      <a className={props.classes.title} href={href}>
        <Card.Img variant="top" src={playlist.cover_art_url} style={{ cursor: 'pointer' }}/>
      </a>
      <Card.Body>
        <Card.Title style={{ cursor: 'pointer' }}>
          <a className={props.classes.title} href={href}>
            <Text type='bodyRegular' color='White' >{playlist.name}</Text>
          </a>
        </Card.Title>
      </Card.Body>
  </Card>
  )
}

const style = (theme: typeof adminPalette) => {
  return {
    title: {
      textDecoration: 'none',
    },
    card: {
      width: '18rem',
      backgroundColor: theme.Muted
    }
  }
}

export default withStyles(style)(PlaylistCard)
