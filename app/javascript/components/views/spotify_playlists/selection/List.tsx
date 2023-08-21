import React from 'react'
import Container from 'react-bootstrap/Container'
import Row from 'react-bootstrap/Row'
import Col from 'react-bootstrap/Col'
import withStyles from 'react-jss'

import { PlaylistCard } from './'
import { serializedSpotifyPlaylist } from '../../../types'

type ListProps = {
  playlists: serializedSpotifyPlaylist[],
  classes: any
}

const List = (props: ListProps) => {
  if (props.playlists?.length > 0) {
    return (
      <Container>
        <Row>
          {
            props.playlists.map((playlist, id) => {
              return (
                <Col key={id}>
                  <PlaylistCard playlist={playlist}/>
                </Col>
              )
            })
          }
          </Row>
      </Container>
    )
  }

  return (null)
}

const styles = (theme: any) => {
  return {}
}

export default withStyles(styles)(List)
