import React from 'react'
import withStyles from 'react-jss'

import { Text } from '../../common/'

type VotingBoxProps = {
  classes: any
}

const VotingBox = (props: VotingBoxProps) => {
  return (
    <div className={props.classes.container}>
      <div className={props.classes.title}>
        <Text type='bodyRegular' color='White'>Siguiente canción...</Text>
      </div>
      <div className={props.classes.progressBarBoxContainer}>
        <div className={props.classes.progressBarReference} />
        <div className={props.classes.progressBarInnerContainer}>
          <div className={props.classes.progressBarContainer}>
            <div className={props.classes.topProgressBar}>76%</div>
            <div className={props.classes.progressImage}>
              <img src='https://i.scdn.co/image/ab67616d000048514ae1c4c5c45aabe565499163' height='48' width='48'/>
            </div>
          </div>
          <div className={props.classes.progressBarContainer}>
            <div className={props.classes.bottomProgressBar}>
              24%
            </div>
            <div className={props.classes.progressImage}>
              <img src='https://i.scdn.co/image/ab67616d00004851b6d4566db0d12894a1a3b7a2' height='48' width='48'/>
            </div>
          </div>
        </div>
      </div>
    </div>
  )
}

const styles = (theme: any) => {
  return {
    container: {
      width: '20rem',
      height: '20rem',
      backgroundColor: '#6F7A90',
      display: 'flex',
      flexDirection: 'column',
      justifyContent: 'flex-start'
    },
    title: {
      composes: 'pt-2 ps-3 mb-3'
    },
    progressBarBoxContainer: {
      display: 'flex',
      flexDirection: 'row',
      justifyContent: 'center',
      width: '90%',
      composes: 'mt-4 ms-2'
    },
    progressBarReference: {
      backgroundColor: theme.White,
      height: '11rem',
      width: '0.5rem'
    },
    progressBarInnerContainer: {
      display: 'flex',
      flexDirection: 'column',
      justifyContent: 'space-around'
    },
    progressBarContainer: {
      display: 'flex',
      flexDirection: 'row',
      alignItems: 'center'
    },
    topProgressBar: {
      backgroundColor: '#0000FF',
      height: '3.75rem',
      width: '12.375rem',
      display: 'flex',
      alignItems: 'center',
      justifyContent: 'center',
      composes: '$progressBarText'
    },
    bottomProgressBar: {
      backgroundColor: '#FF00FF',
      height: '3.75rem',
      width: '7.5rem',
      display: 'flex',
      alignItems: 'center',
      justifyContent: 'center',
      composes: '$progressBarText'
    },
    progressBarText: {
      color: theme.White,
      fontFamily: 'Poppins',
      fontSize: '1.5rem'
    },
    progressImage: {
      backgroundColor: theme.White,
      width: '60px',
      height: '60px',
      composes: 'ms-2',
      display: 'flex',
      justifyContent: 'center',
      alignItems: 'center',
      borderRadius: '6px'
    }
  }
}

export default withStyles(styles)(VotingBox)
