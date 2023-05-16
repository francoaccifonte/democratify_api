import React from 'react'
import Col from 'react-bootstrap/Col'
import Container from 'react-bootstrap/Container'
import Button from 'react-bootstrap/Button'
import Image from 'react-bootstrap/Image'

import { FullHeightSkeleton } from '../../../common'
import { serializedAccount, serializedSpotifyPlaylist } from '../../../types'

type SpotifyPlaylistShowViewProps = {
  playlist: serializedSpotifyPlaylist,
  account: serializedAccount
}

const SpotifyPlaylistShowView = (props: SpotifyPlaylistShowViewProps) => {
  const { playlist } = props
  return (
    <FullHeightSkeleton header footer palette='admin'>
      <Container className="d-flex flex-row justify-content-between">
        <Col md={4} className="align-items-center d-flex flex-column">
          <Image src={playlist.cover_art_url} fluid/>
          <div className="d-grid gap-2" style={{ width: '100%' }}>
            <Button variant='primary' className="mt-5" size="lg" >
              Reproducir
            </Button>
          </div>
        </Col>
        <Col md={6} className="text-white">
          {
            playlist.spotify_songs.map((data, id) => {
              return (
                <div key={id}>
                  {data.title}
                  <br />
                </div>
              )
            })
          }
        </Col>
      </Container>
    </FullHeightSkeleton>
  )
}

export default SpotifyPlaylistShowView
