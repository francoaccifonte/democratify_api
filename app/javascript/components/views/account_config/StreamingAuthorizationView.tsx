import React from 'react'
import withStyles from 'react-jss'

import { FullHeightSkeleton, Text } from '../../common'
import StreamingCard from './StreamingCard'
import { serialized_account } from '../../types/serialized_account'

type StreamingAuthorizationViewProps = {
  classes: any;
  account: serialized_account
}
const StreamingAuthorizationView = (props: StreamingAuthorizationViewProps) => {
  const { classes } = props
  return (
    <FullHeightSkeleton flexDirectionColumn={true} header palette='admin' overflowY="hidden">
      <div className={classes.caption}><Text type="bodyRegular" color="White">Enlaza tu cuenta de Streaming</Text></div>
      <div className={classes.container}>
        <StreamingCard account={props.account} service="Spotify"/>
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
      flexDirection: 'row',
      justifyContent: 'space-around',
      alignItems: 'flex-start',
      composes: 'mt-5'
    },
    caption: {
      width: '100%',
      textAlign: 'center',
      composes: 'pt-5'
    }
  }
}
export default withStyles(styles)(StreamingAuthorizationView)
