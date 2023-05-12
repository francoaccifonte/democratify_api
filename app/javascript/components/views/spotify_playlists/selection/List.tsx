import React from 'react'
import Container from 'react-bootstrap/Container'
import Row from 'react-bootstrap/Row'
import Col from 'react-bootstrap/Col'

import { PlaylistCard } from './'
import { serialized_spotify_playlist } from '../../../types'


type ListProps = {
  playlists: serialized_spotify_playlist[],
}

const List = (props: ListProps) => {
  if (props.playlists.length > 0) {
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

  return (<></>)
}

export default List
