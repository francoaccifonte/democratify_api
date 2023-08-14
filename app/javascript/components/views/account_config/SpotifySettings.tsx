import React, { useState } from 'react'
import Button from 'react-bootstrap/Button'
import withStyles from 'react-jss'
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome'

import { Text } from '../../common'
import { serializedAccount } from '../../types'
import { SpotifyLoginButton } from './'

type StreamingCardProps = {
  classes: any;
  account: serializedAccount;
  authUri?: string
}

const EmailForm = (props: { editBox: any, email: any } & StreamingCardProps) => {
  const handleChange = (event) => { props.email.setFormEmail(event.target.value) }

  const classes = props.classes
  if (props.editBox.showEditBox) {
    return (
      <>
        <Text type='bodyRegular' color='White'>Email de tu cuenta de Spotify:</Text>
        <br />
        <Text className={props.classes.settingBody} type='bodyRegular' color='White'>{`${props.account.spotify_user?.user_provided_email}`}</Text>
      </>
    )
  } else {
    return (
      <>
        <Text type='bodyRegular' color='White'>Ingresa tu el email asociado a tu cuenta de spotify:</Text>
        <br />
        <div className={classes.settingBody}>
          <form id="login" action="/spotify_users" method="post">
            <input name="email" type="email" value={props.email.formEmail } onChange={handleChange} className={classes.formInput} spellCheck="false" id="email"/>
            <Button type="submit" className={classes.submitButton}>
              <Text type="title" color="Black">Enviar</Text>
            </Button>
          </form>
        </div>
      </>
    )
  }
}

const AuthButton = (props: StreamingCardProps) => {
  return (
    <>
    <Text type="bodyRegular" color="white">Conectar tu cuenta de spotify</Text>
    <div className={props.classes.settingBody}>
      <SpotifyLoginButton account={props.account} authUri={props.authUri} />
    </div>
    </>
  )
}

const StepZeroDescription = (props: StreamingCardProps) => {
  if (props.account.spotify_user?.email) { return null }
  return (
    <div className={props.classes.description}>
      Estamos muy contentos de tenerte a bordo en nuestra fase beta. Para brindarte la mejor experiencia, debemos realizar un paso manual.
      <br />
      Simplemente ingresa tu email, espera a ser añadido a la lista permitida y luego regresa para otorgar a Rockolify acceso en Spotify para controlar la reproducción en tus dispositivos.
      <br />
    </div>
  )
}

const StepOneDescription = (props: StreamingCardProps) => {
  if (props.account.spotify_user?.email) { return null }
  return (
    <div className={props.classes.description}>
      Ya recibimos tu email. Pronto un administrador te agregara a la lista de usuarios permitidos. Vuelve en unos minutos para continuar al siguiente paso.
    </div>
  )
}

const StepTwoDescription = (props: StreamingCardProps) => {
  if (props.account.spotify_user?.email) { return null }
  return (
    <div className={props.classes.description}>
      Ya casi 🥳! Autoriza Rockolify a acceder a tus datos de Spotify
    </div>
  )
}

const StepThreeDescription = (props: StreamingCardProps) => null

const SpotifySettings = (props: StreamingCardProps) => {
  const [showEditBox, setShowEditBox] = useState<Boolean>(!!props.account.spotify_user?.user_provided_email)
  const [formEmail, setFormEmail] = useState<String>()
  const editBox = { showEditBox, setShowEditBox }
  const email = { formEmail, setFormEmail }
  let Description
  console.log(props)
  if (!props.account.spotify_user?.user_provided_email) {
    Description = StepZeroDescription
  } else if (!props.account.spotify_user.whitelisted) {
    Description = StepOneDescription
  } else if (!props.account.spotify_user.email) {
    Description = StepTwoDescription
  } else {
    Description = StepThreeDescription
  }

  const { classes } = props
  return (
    <div className={classes.card}>
      <div className={classes.sectionTitle}>
        <FontAwesomeIcon icon={['fab', 'spotify']} className={props.classes.icon}/>
        <Text type="bodyImportant" color='White'>Spotify</Text>
      </div>
      <div className={classes.body}>
        <Description {...props}/>
        <EmailForm {...props} editBox={editBox} email={email}/>
        <AuthButton {...props} />
      </div>
    </div>
  )
}

const styles = (theme: any) => {
  return {
    card: {
      backgroundColor: theme.Muted,
      width: '100%',
      // textAlign: 'center',
      alignItems: 'center',
      borderRadius: '2px',
      paddingTop: '1rem',
      paddingBottom: '1rem',
      paddingLeft: '2rem',
      paddingRight: '2rem'
    },
    sectionTitle: {
      paddingBottom: '0.5rem',
    },
    settingBody: {
      alignText: 'left',
      alignSelf: 'flex-end'
    },
    formInput: {
      backgroundColor: theme.Muted,
      border: 'none',
      borderBottom: '1px solid white',
      color: theme.White,
      marginRight: '0.5rem'
    },
    body: {
      paddingLeft: '2rem',
      display: 'flex',
      flexDirection: 'column'
    },
    icon: {
      color: theme.White,
      fontSize: '20px',
      paddingRight: '1rem'
    },
    description: {
      color: theme.White,
      marginBottom: '1rem'
    }
  }
}

export default withStyles(styles)(SpotifySettings)
