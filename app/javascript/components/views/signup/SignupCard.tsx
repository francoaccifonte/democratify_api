import React, { useState } from 'react'
import Container from 'react-bootstrap/Container'
import Card from 'react-bootstrap/Card'
import Button from 'react-bootstrap/Button'
import withStyles from 'react-jss'

import { LoadingSpinner, Text } from '../../common/'

const styles = (theme: any) => {
  console.log(theme)
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

type SignupCardProps = { classes: any };

const SignupCard = (props: SignupCardProps) => {
  const { classes } = props

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
  const handleSubmit = (event: any) => {
    event.preventDefault()
    if (isDataValid()) {
      // signUp({ email: emailValue, password: passwordValue, name: userValue })
    }
  }

  return (
    <Container className={classes.container}>
        <Card className={classes.card}>
          <Card.Body className="text-left">
          <form>
            <input type="text" value={userValue} onChange={handleUserChange} className={classes.formInput} spellCheck="false"/>
            <br />
            <Text type="bodyCaption" color="White">
              USUARIO
            </Text>
            <input type="password" value={passwordValue} onChange={handlePasswordChange} className={validPassword() ? classes.formInput : classes.formInputDanger}/>
            <br />
            <Text type="bodyCaption" color="White">
              CONTRASEÑA
            </Text>
            <input type="password" value={repeatPasswordValue} onChange={handleRepeatPasswordChange} className={validPassword() ? classes.formInput : classes.formInputDanger}/>
            <br />
            <Text type="bodyCaption" color="White">
              CONFIRMAR CONTRASEÑA
            </Text>
            <input type="email" value={emailValue} onChange={handleEmailChange} className={classes.formInput} spellCheck="false"/>
            <br />
            <Text type="bodyCaption" color="White">
              CORREO ELECTRÓNICO
            </Text>
          </form>
          </Card.Body>
          <Card.Body className="text-center">
            <Button className={classes.submitButton} onClick={handleSubmit} disabled={false}>
              <LoadingSpinner />
            </Button>
            <br />
            <Text type="bodyRegular" color="White">Ya tenes cuenta? </Text>
            <Text type="link" color="White" href="/account/login">Entrar</Text>
          </Card.Body>
        </Card>
    </Container>
  )
}

export default withStyles(styles)(SignupCard)
