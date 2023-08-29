export type TextStyle = {
  fontFamily: string,
  fontStyle: string,
  fontWeight: number | string,
  fontSize: string,
  lineHeight: string,
  cursor?: 'pointer'
  '&:hover'?: any,
  textDecoration?: string,
}

const header: TextStyle = {
  fontFamily: 'Poppins',
  fontStyle: 'normal',
  fontWeight: 600,
  fontSize: '2.5rem',
  lineHeight: '3.75rem'
}
const title: TextStyle = {
  fontFamily: 'Poppins',
  fontStyle: 'normal',
  fontWeight: 600,
  fontSize: '1rem',
  lineHeight: '1.5rem'
}
const bodyRegular: TextStyle = {
  fontFamily: 'Poppins',
  fontStyle: 'normal',
  fontWeight: 400,
  fontSize: '1.125rem',
  lineHeight: '1.75rem'
}
const bodyImportant: TextStyle = {
  fontFamily: 'Poppins',
  fontStyle: 'normal',
  fontWeight: 400,
  fontSize: '1.5rem',
  lineHeight: '2.25rem'
}
const bodyCaption: TextStyle = {
  fontFamily: 'Poppins',
  fontStyle: 'normal',
  fontWeight: 'normal',
  fontSize: '0.75rem',
  lineHeight: '1.125rem'
}
const link: TextStyle = {
  fontFamily: 'Poppins',
  fontStyle: 'normal',
  fontWeight: 600,
  fontSize: '1.125rem',
  lineHeight: '1.75rem',
  cursor: 'pointer',
  textDecoration: 'none',
  '&:hover': {
    cursor: 'pointer'
  }
}

const TextStyles = {
  header,
  title,
  bodyRegular,
  bodyImportant,
  bodyCaption,
  link,
}

export { TextStyles }
