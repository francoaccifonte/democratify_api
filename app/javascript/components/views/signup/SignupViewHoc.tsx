import React from 'react'
import withStyles, { ThemeProvider } from 'react-jss'

import { SignupView } from '.'
import { adminPalette } from '../../ColorPalette'

const SignupViewHoc = () => {
  return (
    <ThemeProvider theme={adminPalette}>
      <SignupView />
    </ThemeProvider>
  )
}

export default SignupViewHoc
