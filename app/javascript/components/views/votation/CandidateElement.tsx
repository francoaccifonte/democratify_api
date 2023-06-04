import React from 'react'
import Image from 'react-bootstrap/Image'
import Container from 'react-bootstrap/Container'
import Row from 'react-bootstrap/Row'
import Col from 'react-bootstrap/Col'

import { serializedVotationCandidate } from '../../types'
import { Text } from '../../common'

type CandidateElementProps = {
  data: serializedVotationCandidate,
  key: number,
  onSelect: Function,
  selected?: number,
  disabled?: boolean,
};

const CandidateElement = (props: CandidateElementProps) => {
  const isSelected = props.selected === props.data.id
  const backgroundColor = props.disabled
    ? '#3CA1FF'
    : isSelected
      ? '#0B65B8'
      : '#E782D1'
  return (

    <Container className="my-4 py-2 rounded-3" style={{ background: backgroundColor }} >
      <Row onClick={() => props.onSelect()}>
        <Col xs={4}>
          <Image src={props.data.spotify_song?.cover_art[1].url} style={{ maxWidth: '5rem' }}/>
        </Col>
        <Col xs={8}>
          <Container>
            <Row className="text-truncate"><Text type="bodyImportant" color="black">{props.data.spotify_song?.title}</Text></Row>
            <Row className="text-truncate"><Text type="bodyImportant" color="black">{props.data.spotify_song?.artist}</Text></Row>
          </Container>
        </Col>
      </Row>
    </Container>
  )
}

export default CandidateElement
