import React from 'react'
import { ThemeProvider } from 'react-jss'

import { StreamingAuthorizationView } from '.'
import { adminPalette } from '../../ColorPalette'
import { serializedAccount, jsonTo } from '../../types'

type AccountConfigViewHocProps = {
  account: string,
  spotifyAuthUri: string
}

const AccountConfigViewHoc = (props: AccountConfigViewHocProps) => {
  const account: serializedAccount = jsonTo<serializedAccount>(props.account)

  return (
    <ThemeProvider theme={adminPalette}>
      <StreamingAuthorizationView account={account} spotifyAuthUri={props.spotifyAuthUri}/>
    </ThemeProvider>
  )
}

export default AccountConfigViewHoc
