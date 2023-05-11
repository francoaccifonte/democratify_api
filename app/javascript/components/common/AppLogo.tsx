import React from 'react'
import withStyles from 'react-jss'

if (process.env.NODE_ENV === 'test') {
  var logo = ''
} else {
  var logo = require("../../../assets/images/logo.svg") as string;
}

type LogoProps = {
  classes: any
}

const AppLogo: React.FC = (props: LogoProps) => {
  if (process.env.NODE_ENV === 'test') { return <div /> }
  return <img src={logo} className={props.classes.logo}/>
}

const styles = (theme: any) => {
  return {
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

export default withStyles(styles)(AppLogo)
