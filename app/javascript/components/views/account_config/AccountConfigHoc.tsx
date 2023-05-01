import React from 'react'
import withStyles, { ThemeProvider } from 'react-jss'

import { StreamingAuthorizationView } from '.'
import { adminPalette } from '../../ColorPalette'

const HomeHoc = () => {
  return (
    <ThemeProvider theme={adminPalette}>
      <StreamingAuthorizationView />
    </ThemeProvider>
  )
}

export default HomeHoc
