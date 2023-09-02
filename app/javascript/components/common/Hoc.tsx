import React from 'react'

import { ThemeProvider } from 'react-jss'
import { Palette, adminPalette } from '../ColorPalette'
import { FooterContext, ResponsiveContext } from '../views/contexts/'
import { serializedVotation, serializedOngoingPlaylist, jsonTo } from '../types'
import { DeviceTypes } from './size_helpers'
import { useMediaQuery } from 'react-responsive'

type HocPropsType = {
  ongoingPlaylist?: string;
  votation?: string;
  palette?: Palette
}

type HocType = HocPropsType & {
  children: React.ReactNode
}

const Hoc = (props: HocType): JSX.Element => {
  const ongoingPlaylist = props.ongoingPlaylist ? jsonTo<serializedOngoingPlaylist>(props.ongoingPlaylist) : null
  const votation = props.votation ? jsonTo<serializedVotation>(props.votation) : null
  const devices = DeviceTypes(useMediaQuery)
  return (
    <ThemeProvider theme={props.palette || adminPalette}>
      <FooterContext.Provider value={{ ongoingPlaylist, votation }}>
        <ResponsiveContext.Provider value={devices}>
          {props.children}
        </ResponsiveContext.Provider>
      </FooterContext.Provider>
    </ThemeProvider>
  )
}

export default Hoc
export { HocPropsType }
