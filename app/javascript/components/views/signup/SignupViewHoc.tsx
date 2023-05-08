import React from 'react'
import withStyles, { ThemeProvider } from 'react-jss'

import { SignupView, } from '.'
import { adminPalette } from '../../ColorPalette'

type SignupViewProps = {
  signupSuccessful?: Boolean
}

const SignupViewHoc = (props: SignupViewProps) => {
  return (
    <ThemeProvider theme={adminPalette}>
      <SignupView {...props}/>
    </ThemeProvider>
  )
}

export default SignupViewHoc
