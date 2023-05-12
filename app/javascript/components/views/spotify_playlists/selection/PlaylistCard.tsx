import React from 'react'
import Card from 'react-bootstrap/Card'
import { useTheme } from 'react-jss'
import withStyles from 'react-jss'

import { Text } from '../../../common'
import { serialized_spotify_playlist } from '../../../types'

type PlaylistCardProps = {
  classes: any;
  playlist: serialized_spotify_playlist;
  theme?: any;
}

const PlaylistCard = (props: PlaylistCardProps) => {
  const { playlist } = props;
  const theme: any = useTheme()
  const href = `/playlists/${playlist.id}`
  return (
    <Card style={{ width: '18rem', backgroundColor: theme?.Muted }} className='mb-3 mt-3'>
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

const style = (theme) => {
  return {
    title: {
      textDecoration: 'none',
    }
  }
}

export default withStyles(style)(PlaylistCard)
