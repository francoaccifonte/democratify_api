import React from 'react'
import Container from 'react-bootstrap/Container'
import { findColor, ColorProps, adminPalette } from '../ColorPalette'

type BackgroundContainerProps = {
  backgroundColor: { palette: ColorProps['palette']},
  children: React.ReactNode,
}

const BackgroundContainer = (props: BackgroundContainerProps) => {
  const { palette } = props.backgroundColor
  const color = 'Light'
  const backgroundColor = findColor({ palette, color }) || adminPalette.Light

  return (
    <Container
      className="d-flex flex-column"
      style={{ padding: '0', background: backgroundColor, height: '100vh', overflowY: 'hidden', alignItems: 'flex-start' }}
      fluid
    >
      {props.children}
      </Container>
  )
}

export default BackgroundContainer
