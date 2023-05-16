import React from 'react'
import { ThemeProvider } from 'react-jss'

import { LoginView } from './'
import { adminPalette } from '../../ColorPalette'

type LoginViewProps = {
  failedAuth?: Boolean
}

const LoginViewHoc = (props: LoginViewProps) => {
  return (
    <ThemeProvider theme={adminPalette}>
      <LoginView {...props}/>
    </ThemeProvider>
  )
}

export default LoginViewHoc
