import React from 'react'
import withStyles, { ThemeProvider } from 'react-jss'

import { LoginView } from './'
import { adminPalette } from '../../ColorPalette'

const HomeHoc = () => {
  return (
    <ThemeProvider theme={adminPalette}>
      <LoginView />
    </ThemeProvider>
  )
}

export default HomeHoc
