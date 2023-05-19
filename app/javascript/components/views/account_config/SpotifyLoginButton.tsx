import React from 'react'
import Button from 'react-bootstrap/Button'
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome'
import withStyles from 'react-jss'

import { Text } from '../../common'
import { serializedAccount } from '../../types/serializedAccount'

type SpotifyLoginButtonProps = {
  classes?: any;
  account: serializedAccount;
  authUri: string
}

const SpotifyLoginButton = (props: SpotifyLoginButtonProps) => {
  const alreadyLinked = (!!props.account.spotify_user)

  const DisabledMessage = () => {
    if (alreadyLinked) {
      return (
        <>
          <br />
          <Text type="bodyRegular" color="White">Spotify ya fue vinculado</Text>
        </>
      )
    }
    return <></>
  }

  return (
    <Button
      variant="link"
      href={props.authUri}
      target="_blank"
      disabled={alreadyLinked}
    >
    <FontAwesomeIcon icon={['fab', 'spotify']} className={props.classes.icon}/>
    <DisabledMessage />
  </Button>
  )
}

const styles = (theme: any) => {
  return {
    icon: {
      color: theme.White,
      fontSize: '200px'
    }
  }
}

export default withStyles(styles)(SpotifyLoginButton)
