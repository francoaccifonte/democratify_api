import React from 'react'
import withStyles from 'react-jss'

import { ColorProps } from '../ColorPalette'
import { AppLogo, Text } from './'

export const useAppHeaderUtils = () => {
  return {
    readyToShow: () => true
  }
}

type HeaderProps = {
  palette: ColorProps['palette']
  isMobile?: boolean;
  public?: boolean;
  className?: string;
  style?: React.CSSProperties;
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
      // if (userIsLoggedIn()) { return <UserSetupDropdown /> }
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
      '&:hover': {
        cursor: 'pointer'
      }
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
