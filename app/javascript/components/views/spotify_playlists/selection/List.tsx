import React from 'react'
import Container from 'react-bootstrap/Container'
import Row from 'react-bootstrap/Row'
import Col from 'react-bootstrap/Col'
import withStyles from 'react-jss'
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome'

import { PlaylistCard } from './'
import { serializedSpotifyPlaylist } from '../../../types'
import { Text } from '../../../common'

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

  return (
    <div className={props.classes.empyState} >
      <Text type="bodyRegular" color="white">
        <FontAwesomeIcon icon={['fas', 'microphone-slash']} /> No se encontraron playlists
      </Text>
    </div>
  )
}

const styles = (theme: any) => {
  return {
    empyState: {
      color: theme.White
    }
  }
}

export default withStyles(styles)(List)
