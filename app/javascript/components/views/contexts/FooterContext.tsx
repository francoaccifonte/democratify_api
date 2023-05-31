import { createContext } from 'react'
import { serializedOngoingPlaylist, serializedVotation } from '../../types'

type FooterContextType = {
  ongoingPlaylist: serializedOngoingPlaylist;
  votation: serializedVotation
}

export const FooterContext = createContext<FooterContextType>({
  ongoingPlaylist: null,
  votation: null
})
