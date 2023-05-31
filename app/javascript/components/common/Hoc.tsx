import React from 'react'

import { ThemeProvider } from 'react-jss'
import { adminPalette } from '../ColorPalette'
import { FooterContext } from '../views/contexts/FooterContext'
import { serializedVotation, serializedOngoingPlaylist, jsonTo } from '../types'

type HocPropsType = {
  ongoingPlaylist: string;
  votation: string;
}

type HocType = HocPropsType & {
  children: React.ReactNode
}

const Hoc = (props: HocType): JSX.Element => {
  const ongoingPlaylist: serializedOngoingPlaylist = jsonTo<serializedOngoingPlaylist>(props.ongoingPlaylist)
  const votation: serializedVotation = jsonTo<serializedVotation>(props.votation)
  return (
    <ThemeProvider theme={adminPalette}>
      <FooterContext.Provider value={{ ongoingPlaylist, votation }}>
        {props.children}
      </FooterContext.Provider>
    </ThemeProvider>
  )
}

export default Hoc
export { HocPropsType }
