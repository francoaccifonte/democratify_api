import { createContext } from 'react'

type ResponsiveContextType = {
  isMobile?: boolean;
  isDesktop?: boolean;
}

export const ResponsiveContext = createContext<ResponsiveContextType>({
  isMobile: null,
  isDesktop: null
})
