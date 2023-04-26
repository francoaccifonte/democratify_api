import React from 'react'
import withStyles from 'react-jss'

import { Text } from './'

type PlayerFooterProps = {
  className?: string,
  style?: React.CSSProperties,
  classes: any
}

const LandingFooter = (props: PlayerFooterProps) => {
  return (
    <div className={props.classes.container + ' ' + (props?.className || '')} >
      <div className={props.classes.link}>
        <Text type='bodyRegular' color="White">Preguntas frecuentes</Text>
      </div>
      <div>
        <Text type='bodyRegular' color="White">Rokolify © {String(new Date().getFullYear())}</Text>
      </div>
    </div>
  )
}

const styles = (theme: any) => {
  return {
    container: {
      backgroundColor: theme.Primary,
      width: '100%',
      height: '8rem',
      display: 'flex',
      flexDirection: 'column',
      alignItems: 'center',
      justifyContent: 'center'
    }
  }
}

export default withStyles(styles)(LandingFooter)
