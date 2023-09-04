import React from 'react'
import { useSelector } from 'react-redux'
import Image from 'react-bootstrap/Image'

type QrProps = {
  accountId: number
}

const QR: React.FC<QrProps> = (props) => {
  const { accountId } = props
  const uri = `https://chart.googleapis.com/chart?cht=qr&chs=300x300&chl=https://rockolify.holasoyfranco.com/account/${accountId}/votation`
  return <Image src={uri} />
}

const openQrOnNewWindow = (accountId?: number) => {
  const uri = `https://chart.googleapis.com/chart?cht=qr&chs=400x400&chl=https://rockolify.holasoyfranco.com/account/${accountId}/votation`
  window.open(uri, '_blank')
}

export default QR
export { openQrOnNewWindow }
