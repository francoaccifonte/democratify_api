import { TextStyles } from './sharedStyles/text'
import { adminPalette as adminColors, userPalette as userColors } from './sharedStyles/colors'

const adminPalette = {
  ...adminColors,
  text: TextStyles
}
const userPalette = {
  ...userColors,
  text: TextStyles
}

type Palettes = 'admin' | 'user';
type ColorKeys = keyof typeof adminPalette | keyof typeof userPalette;
export type ColorProps= {
  palette: Palettes,
  color: ColorKeys,
}

const findColor = (params: ColorProps) => {
  switch (params.palette) {
    case 'admin':
      return adminPalette[params.color]
    case 'user':
      return userPalette[params.color]
    default:
      return null
  }
}

export { adminPalette, userPalette, findColor }
