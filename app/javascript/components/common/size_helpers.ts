import { useMediaQuery } from 'react-responsive'

export const DeviceTypes = () => {
  return {
    isDesktop: useMediaQuery({ minWidth: 576 }),
    isMobile: useMediaQuery({ maxWidth: 576 })
  }
}
