export type Palette = {
  Primary: string;
  Secondary: string;
  Success: string;
  Warning: string;
  Danger: string;
  Info: string;
  Light: string;
  Dark: string;
  Muted: string;
  White: string;
  Black: string;
}

const adminPalette = {
  Primary: '#0B2355',
  Secondary: '#021335',
  Success: '#80C999',
  Warning: '#DABC6F',
  Danger: '#D02B35',
  Info: '#B8C6E0',
  Light: '#203661',
  Dark: '#000000',
  Muted: '#5571AA',
  White: '#FFFFFF',
  Black: '#000000'
}

const userPalette: Palette = {
  Primary: '#63034E',
  Secondary: '#39002D',
  Success: '#0B65B8',
  Warning: '#F88703',
  Danger: '#8B0A0A',
  Info: '#DA62C0',
  Light: '#770B5F',
  Dark: '#000000',
  Muted: '#AA1E8B',
  White: '#FFFFFF',
  Black: '#000000'
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
