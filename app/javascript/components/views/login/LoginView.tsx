import React, { useState, useEffect } from 'react'
import Container from 'react-bootstrap/Container'
import Card from 'react-bootstrap/Card'
import Button from 'react-bootstrap/Button'
import withStyles from 'react-jss'

import { FullHeightSkeleton, LoadingSpinner, Text } from '../../common'
import client from '../../../requests'

type LogInViewProps = { 
  classes: any;
  failedAuth: Boolean
};
const LoginView = (props: LogInViewProps) => {
  const classes = props.classes

  const [email, setEmail] = useState<string>('')
  const [password, setPassword] = useState<string>('')
  const [logInState, setLogInState] = useState<'idle' | 'pending' | 'fulfilled' | 'rejected'>('idle')

  const handleLogIn = async (event: React.MouseEvent<HTMLInputElement>) => {
    setLogInState('pending')
  }

  const handleChange = (event: React.ChangeEvent<HTMLInputElement>) => {
    const id = event.target.getAttribute('id')
    const value = event.target.value
    if (id === 'email') {
      setEmail(value)
    } else if (id === 'password') {
      setPassword(value)
    }
  }

  const isDataValid = () => {
    return true
  }

  const ErrorMessage = () => {
    if (props.failedAuth) return (<Text type="title" color="Danger">Usuario o contraseña incorrectos</Text>)
    return null
  }

  return (
    <FullHeightSkeleton header palette='admin' overflowY="hidden">
      <Container className={classes.container}>
        <Card className={classes.card}>
          <Card.Body className="text-left">
            <form id="login" action="/accounts/login" method="post">
              <input name="email" type="email" value={email} onChange={handleChange} className={classes.formInput} spellCheck="false" id="email"/>
              <br />
              <label >
                EMAIL
              </label>
              <input name="password" type="password" value={password} onChange={handleChange} className={classes.formInput} id="password"/>
              <br />
              <label >
                CONTRASEÑA
              </label>

              <div className={classes.messageContainer}>
                <ErrorMessage />
                <Button type="submit" className={classes.submitButton} onClick={handleLogIn} disabled={!isDataValid() && logInState !== 'pending'}>
                  { logInState !== 'pending' && <Text type="title" color="Black">Enviar</Text>}
                  { logInState === 'pending' && <LoadingSpinner />}
                </Button>
              </div>
            </form>
            <Text type="bodyRegular" color="White">No tenés cuenta? </Text>
            <Text type="link" color="White" href='/accounts/signup'>Registrate</Text>
          </Card.Body>
        </Card>
      </Container>
    </FullHeightSkeleton>
  )
}

const styles = (theme: any) => {
  return {
    container: {
      marginTop: '3.5rem',
      width: '380px'
    },
    card: {
      backgroundColor: theme.Muted,
      padding: '28px',
      borderRadius: '6px'
    },
    messageContainer: {
      textAlign: 'center',
      display: 'flex',
      justifyContent: 'center',
      alignItems: 'center',
      flexDirection: 'column'
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
      composes: 'px-5 mt-3'
    }
  }
}

export default withStyles(styles)(LoginView)
