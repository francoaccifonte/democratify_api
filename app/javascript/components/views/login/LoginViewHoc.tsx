import React from 'react'
import withStyles, { ThemeProvider } from 'react-jss'

import { LoginView } from './'
import { adminPalette } from '../../ColorPalette'

const LoginViewHoc = () => {
  return (
    <ThemeProvider theme={adminPalette}>
      <LoginView />
    </ThemeProvider>
  )
}

export default LoginViewHoc
