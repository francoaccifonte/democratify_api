import React from 'react'
import withStyles from 'react-jss'

import { ColorProps } from '../ColorPalette'
import { Text } from './'
const logo = require("../../../assets/images/logo.svg") as string;

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
  const LogInButtons = () => {
    return (
      <>
        <Text type="link" color="White" className="pe-5" href="/login">Entrar</Text>
        <Text type="link" color="White" href="/signup">Registrarse</Text>
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
      <div className={props.classes.brand}>
        <img src={logo} className={props.classes.logo}/>
        <Text type="header" color="white">Rokolify</Text>
      </div>
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
      alignItems: 'center'
    },
    leftCluster: {
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
      display: 'flex',
      flexDirection: 'row',
      justifyContent: 'center',
      alignItems: 'center'
    },
    logo: {
      height: '4rem',
      width: '4rem',
      composes: 'm-3',
      '&:hover': {
        cursor: 'pointer'
      }
    }
  }
}
export default withStyles(styles)(AppHeader)
