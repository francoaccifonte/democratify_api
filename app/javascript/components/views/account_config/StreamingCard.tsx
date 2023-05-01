import React from 'react'
import Card from 'react-bootstrap/Card'
import withStyles from 'react-jss'

import { Text } from '../../common'
import { SpotifyLoginButton, YoutubeLoginButton  } from './'

type StreamingCardProps = {
  classes: any,
  service: 'Spotify' | 'Youtube'
}

const StreamingCard = (props: StreamingCardProps) => {
  const { classes } = props
  const CardComponent = () => {
    if (props.service === 'Spotify') { return <SpotifyLoginButton /> }
    if (props.service === 'Youtube') { return <YoutubeLoginButton /> }
    return <></>
  }
  return (
    <Card className={classes.card}>
      <CardComponent />
      <Text type="header" color="White">{`${props.service}`}</Text>
    </Card>
  )
}

const styles = (theme: any) => {
  return {
    card: {
      backgroundColor: theme.Muted,
      width: '400px',
      textAlign: 'center',
      alignItems: 'center',
      composes: 'py-4'
    },
    icon: {
      color: theme.White,
      fontSize: '200px'
    }
  }
}

export default withStyles(styles)(StreamingCard)
