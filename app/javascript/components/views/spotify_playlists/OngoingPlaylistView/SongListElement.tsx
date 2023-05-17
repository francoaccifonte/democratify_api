import React from 'react'
import Row from 'react-bootstrap/Row'
import Col from 'react-bootstrap/Col'
import Image from 'react-bootstrap/Image'

import { serializedSpotifySong } from '../../../types'
import { Text } from '../../../common'
import { adminPalette } from '../../../ColorPalette'

type songListProps = {
  rowNumber: number;
  data: serializedSpotifySong;
  poolSize: number;
}

const SongListElement: React.FC<songListProps> = ({ rowNumber, data, poolSize }): JSX.Element => {
  const color = rowNumber < poolSize ? adminPalette.Success : adminPalette.Secondary

  return (
    <>
      <Row className={'my-2 px-2 py-2'} style={{ backgroundColor: color }}>
        <Col lg={1}>
          <Image src={data.cover_art[2].url} alt="album art" roundedCircle/>
        </Col>
        <Col xs={4} sm={3}>
          <Text type="bodyRegular" color="White">{data.title}</Text>
        </Col>
        <Col xs={4} sm={3}>
          <Text type="bodyRegular" color="White">{data.artist}</Text>
        </Col>
        <Col sm={4} className="d-none d-sm-block">
          <Text type="bodyRegular" color="White">{data.album}</Text>
        </Col>
      </Row>
    </>
  )
}

export default SongListElement
