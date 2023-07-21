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
  const alreadyLinked = (!!props.account?.spotify_user?.email)

  const DisabledMessage = () => {
    if (alreadyLinked) {
      return (
        <>
          <Text type="bodyRegular" color="White">Vinculado con exito!</Text>
        </>
      )
    }
    return <></>
  }

  const ShowButton = (props) => {
    if (alreadyLinked) { return null }
    return (
      <Button
        href={props.authUri}
        target="_blank"
        disabled={alreadyLinked}
      >
        <FontAwesomeIcon icon={['fab', 'spotify']} className={props.classes.icon}/>
        <Text type="bodyRegular" className={props.classes.buttonText}>Conectar</Text>
      </Button>
    )
  }

  return (
    <>
    <ShowButton {...props} />
    <DisabledMessage />
    </>
  )
}

const styles = (theme: any) => {
  return {
    icon: {
      color: theme.White,
    },
    buttonText: {
      paddingLeft: '0.5rem'
    }
  }
}

export default withStyles(styles)(SpotifyLoginButton)
