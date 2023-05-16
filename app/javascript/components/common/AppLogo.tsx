import React from 'react'
import withStyles from 'react-jss'

// TODO: why is the lint complaining about redeclare?
if (process.env.NODE_ENV === 'test') {
  // eslint-disable-next-line no-var
  var logo = ''
} else {
  // eslint-disable-next-line no-var, no-redeclare
  var logo = require('../../../assets/images/logo.svg') as string
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
