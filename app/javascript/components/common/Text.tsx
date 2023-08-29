import React from 'react'
import { TextStyles } from '../sharedStyles/text'

type TextProps = {
  type: 'header' | 'title' | 'bodyRegular' | 'bodyImportant' | 'bodyCaption' | 'link';
  color?: string;
  children: React.ReactNode;
  onClick?: () => void;
  className?: string;
  href?: string;
  style?: any;
}

const Text = (props: TextProps) => {
  const normalStyle: any = TextStyles[props.type]
  normalStyle.color = props.color

  const style = { ...normalStyle, ...props.style }

  if (props.type === 'link') {
    const handleOnClick: React.MouseEventHandler<HTMLAnchorElement> = (event) => {
      event.preventDefault()
      window.location.href = props.href
    }
    return <a className ={props.className} style={style} href={props.href} onClick={handleOnClick} >{props.children}</a>
  } else {
    return <span className ={props.className} style={style} onClick={props.onClick}>{props.children}</span>
  }
}

export default Text
