import React from 'react'
import Container from 'react-bootstrap/Container'
import Card from 'react-bootstrap/Card'
import withStyles from 'react-jss'
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome'
import { faCheckCircle } from '@fortawesome/free-solid-svg-icons'

import { Text } from '../../common/'

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
    iconContainer: {
      textAlign: 'center',
      display: 'flex',
      justifyContent: 'center',
      alignItems: 'center',
      flexDirection: 'column'
    },
    icon: {
      color: theme.White,
      fontSize: '100px',
      composes: 'mb-5'
    }
  }
}

type SignupSuccessCardProps = { classes: any };

const SignupSuccessCard = (props: SignupSuccessCardProps) => {
  const classes = props.classes

  return (
    <Container className={classes.container}>
      <Card className={classes.card}>
        <Card.Body className="text-left">
          <div className={classes.iconContainer}>
            <FontAwesomeIcon icon={faCheckCircle} className={classes.icon}/>
            <Text type="bodyCaption" color="White">¡Listo! Ya podes loguearte con tu cuenta.</Text>
            <Text type="link" color="White" href="/accounts/login">Entrar</Text>
          </div>
        </Card.Body>
      </Card>
    </Container>
  )
}

export default withStyles(styles)(SignupSuccessCard)
