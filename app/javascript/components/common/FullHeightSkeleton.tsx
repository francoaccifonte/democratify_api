import React from 'react'
import Container from 'react-bootstrap/Container'

import { AppHeader, BackgroundContainer, LandingFooter, PlayerFooter } from '.'
import { ColorProps } from '../ColorPalette'

type SkeletonProps = {
  header?: boolean | 'landing' | 'default';
  footer?: boolean | 'landing' | 'default';
  flexDirectionColumn?: boolean;
  overflowY?: 'scroll' | 'hidden';
  palette: ColorProps['palette'];
  children: React.ReactNode;
};

const AddHeader = (props: { header?: SkeletonProps['header'], palette: ColorProps['palette'] }) => {
  if (props.header) return <AppHeader palette={props.palette} type={props.header}/>
  return <></>
}

const AddFooter = (props: { footer?: SkeletonProps['footer'] }) => {
  if (props.footer === true || props.footer === 'default') {
    return <PlayerFooter/>
  } else {
    return <LandingFooter className="mt-auto" style={{ alignSelf: 'flex-end' }} />
  }
}

const FullHeightSkeleton = (props: SkeletonProps) => {
  const overflowY = props.overflowY ? props.overflowY : 'scroll'
  const classNames = props.flexDirectionColumn ? 'd-flex align-self-start flex-column' : 'd-flex align-self-start flex-row'

  return (
    <BackgroundContainer backgroundColor={{ palette: props.palette }}>
      <AddHeader header={props.header} palette={props.palette}/>
      <Container className={classNames} style={{ overflowY }}>
        {props.children}
      </Container>
      <AddFooter footer={props.footer}/>
    </BackgroundContainer>
  )
}

export default FullHeightSkeleton
