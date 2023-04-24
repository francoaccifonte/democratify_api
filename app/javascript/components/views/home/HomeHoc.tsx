import React from 'react'
import withStyles, { ThemeProvider } from 'react-jss'

import { Home, VotingBox } from '.'
import { adminPalette } from '../../ColorPalette'

const HomeHoc = () => {
  return (
    <ThemeProvider theme={adminPalette}>
      <Home />
    </ThemeProvider>
  )
}

export default HomeHoc
