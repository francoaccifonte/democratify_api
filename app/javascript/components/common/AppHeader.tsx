import React from 'react'
import withStyles from 'react-jss'
import Cookies from 'js-cookie'

import { AppLogo, Text, UserSetupDropdown } from './'

export const useAppHeaderUtils = () => {
  return {
    readyToShow: () => true
  }
}

type HeaderProps = {
  className?: string;
  classes: any;
  type?: boolean | 'landing' | 'default';
}

const AppHeader = (props: HeaderProps) => {
  const handleLogoClick = (event) => {
    event.preventDefault()
    window.location.href = '/'
  }
  const LogInButtons = () => {
    return (
      <>
        <Text type="link" color="White" className="pe-5" href="/accounts/login">Entrar</Text>
        <Text type="link" color="White" href="/accounts/signup">Registrarse</Text>
      </>
    )
  }

  const RightCluster = ({ type }: { type: HeaderProps['type'] }) => {
    if (type === true || type === 'default') {
      if (Cookies.get('account_id')) { return <UserSetupDropdown /> }
    }
    if (type === 'landing') { return <LogInButtons /> }

    return <></>
  }

  return (
    <div className={props.classes.container}>
      <a className={props.classes.brand} onClick={handleLogoClick} href='/'>
        <AppLogo />
        <Text type="header" color="white">Rockolify</Text>
      </a>
      <div className={props.classes.leftCluster}>
        <RightCluster type={props.type} />
      </div>
    </div>
  )
}

const styles = (theme: any) => {
  return {
    container: {
      width: '100%',
      backgroundColor: theme.Primary,
      display: 'flex',
      flexDirection: 'row',
      justifyContent: 'space-between',
      alignItems: 'center',
    },
    leftCluster: {
      textDecoration: 'none',
      display: 'flex',
      alignItems: 'center',
      composes: 'pe-5',
      color: theme.White,
      '&:hover': {
        cursor: 'pointer'
      }
    },
    userMenu: {
      fontSize: '4rem',
      composes: 'pe-4'
    },
    brand: {
      textDecoration: 'none',
      display: 'flex',
      flexDirection: 'row',
      justifyContent: 'center',
      alignItems: 'center'
    }
  }
}

export default withStyles(styles)(AppHeader)
