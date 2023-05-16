import React from 'react'
import { ThemeProvider } from 'react-jss'

import { Home } from '.'
import { adminPalette } from '../../ColorPalette'

const HomeHoc = () => {
  return (
    <ThemeProvider theme={adminPalette}>
      <Home />
    </ThemeProvider>
  )
}

export default HomeHoc
