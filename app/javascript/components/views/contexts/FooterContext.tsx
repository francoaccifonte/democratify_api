import { createContext } from 'react'
import { serializedOngoingPlaylist, serializedVotation } from '../../types'

type FooterContextType = {
  ongoingPlaylist?: serializedOngoingPlaylist;
  votation?: serializedVotation;
  cognitoEndpoint?: string;
  backendBaseUrl?: string;
}

export const FooterContext = createContext<FooterContextType>({
  ongoingPlaylist: null,
  votation: null,
  cognitoEndpoint: null,
  backendBaseUrl: null
})
