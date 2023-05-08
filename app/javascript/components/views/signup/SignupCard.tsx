import React, { useState } from 'react'
import Container from 'react-bootstrap/Container'
import Card from 'react-bootstrap/Card'
import Button from 'react-bootstrap/Button'
import withStyles from 'react-jss'

import { LoadingSpinner, Text } from '../../common/'

type SignupCardProps = {
  classes: any;
};

const SignupCard = (props: SignupCardProps) => {
  const { classes } = props
  const [requestState, setRequestState] = useState<'idle' | 'pending' | 'fulfilled' | 'rejected'>('idle')

  const [userValue, setUserValue] = useState<string>('')
  const handleUserChange = (event: React.ChangeEvent<HTMLInputElement>) => {
    event.preventDefault()
    setUserValue(event.target.value)
  }

  const [passwordValue, setPasswordValue] = useState<string>('')
  const handlePasswordChange = (event: React.ChangeEvent<HTMLInputElement>) => {
    event.preventDefault()
    setPasswordValue(event.target.value)
  }

  const [repeatPasswordValue, setRepeatPasswordValue] = useState<string>('')
  const handleRepeatPasswordChange = (event: React.ChangeEvent<HTMLInputElement>) => {
    event.preventDefault()
    setRepeatPasswordValue(event.target.value)
  }

  const [emailValue, setEmailValue] = useState<string>('')
  const handleEmailChange = (event: React.ChangeEvent<HTMLInputElement>) => {
    event.preventDefault()
    setEmailValue(event.target.value)
  }

  const validPassword = () => {
    if ((passwordValue.length < 1) || (passwordValue !== repeatPasswordValue)) { return false }
    return true
  }
  const isDataValid = () => {
    if (!validPassword()) { return false }
    if (!emailValue.includes('@')) { return false }

    return true
  }
  const handleSubmit = async (event: any) => {
    setRequestState('pending')
  }
  const disableButton = ():boolean => {
    return !isDataValid() || requestState !== 'idle'
  }

  return (
    <Container className={classes.container}>
        <Card className={classes.card}>
          <form id="signup" action="/accounts/signup" method="post">
            <Card.Body className="text-left">
              <input id="user" name="name" type="text" value={userValue} onChange={handleUserChange} className={classes.formInput} spellCheck="false"/>
              <br />
              <Text type="bodyCaption" color="White">
                USUARIO
              </Text>
              <input id="password" name="password" type="password" value={passwordValue} onChange={handlePasswordChange} className={validPassword() ? classes.formInput : classes.formInputDanger}/>
              <br />
              <Text type="bodyCaption" color="White">
                CONTRASEÑA
              </Text>
              <input id="repeatPassword" type="password" value={repeatPasswordValue} onChange={handleRepeatPasswordChange} className={validPassword() ? classes.formInput : classes.formInputDanger}/>
              <br />
              <Text type="bodyCaption" color="White">
                CONFIRMAR CONTRASEÑA
              </Text>
              <input id="email" name="email" type="email" value={emailValue} onChange={handleEmailChange} className={classes.formInput} spellCheck="false"/>
              <br />
              <Text type="bodyCaption" color="White">
                CORREO ELECTRÓNICO
              </Text>
            </Card.Body>
            <Card.Body className="text-center">
              <Button id="signupButton" type="submit" className={classes.submitButton} onClick={handleSubmit} disabled={disableButton()}>
                {requestState === 'idle' && <Text type="title" color="Black">Enviar</Text>}
                {requestState !== 'idle' && <LoadingSpinner />}
              </Button>
              <br />
              <Text type="bodyRegular" color="White">Ya tenes cuenta? </Text>
              <Text type="link" color="White" href="/accounts/login">Entrar</Text>
            </Card.Body>
          </form>
        </Card>
    </Container>
  )
}

const styles = (theme: any) => {
  return {
    container: {
      width: '380px'
    },
    card: {
      backgroundColor: theme.Muted,
      padding: '28px',
      borderRadius: '6px'
    },
    formInput: {
      backgroundColor: theme.Muted,
      border: 'none',
      borderBottom: '1px solid white',
      color: theme.White,
      fontFamily: 'Poppins',
      fontWeight: '400',
      width: '100%',
      '&:focus': {
        outline: 'none',
        borderBottom: `1px solid ${theme.Primary}`,
        color: theme.Primary
      }
    },
    formInputDanger: {
      composes: '$formInput',
      color: theme.Danger,
      '&:focus': {
        color: theme.Danger
      }
    },
    submitButton: {
      backgroundColor: theme.Info,
      borderRadius: '12px',
      border: 'none',
      composes: 'px-5'
    }
  }
}

export default withStyles(styles)(SignupCard)
