import React from 'react'
import withStyles from 'react-jss'

import { FullHeightSkeleton, Text } from '../../common'
import StreamingCard from './StreamingCard'
import { serializedAccount } from '../../types/serializedAccount'
import { SpotifySettings } from './'

type StreamingAuthorizationViewProps = {
  classes: any;
  account: serializedAccount;
  spotifyAuthUri: string;
}
const StreamingAuthorizationView = (props: StreamingAuthorizationViewProps) => {
  const { classes } = props
  return (
    <FullHeightSkeleton flexDirectionColumn={true} header palette='admin'>
      <div className={classes.caption}><Text type="bodyRegular" color="White">Enlaza tu cuenta de Streaming</Text></div>
      <div className={classes.container}>
        <SpotifySettings account={props.account} authUri={props.spotifyAuthUri}/>
        <StreamingCard account={props.account} service="Spotify" authUri={props.spotifyAuthUri}/>
        <StreamingCard account={props.account} service="Youtube"/>
      </div>
    </FullHeightSkeleton>
  )
}

const styles = (theme: any) => {
  return {
    container: {
      width: '100%',
      display: 'flex',
      flexDirection: 'column',
      rowGap: '10px',
      justifyContent: 'space-around',
      alignItems: 'flex-start'
    },
    caption: {
      width: '100%',
      textAlign: 'center',
      composes: 'pt-5'
    }
  }
}
export default withStyles(styles)(StreamingAuthorizationView)
