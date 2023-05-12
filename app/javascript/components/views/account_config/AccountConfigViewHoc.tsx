import React from 'react'
import withStyles, { ThemeProvider } from 'react-jss'

import { StreamingAuthorizationView } from '.'
import { adminPalette } from '../../ColorPalette'
import { serialized_account, json_to } from '../../types'

type AccountConfigViewHocProps = {
  account: string,
  spotifyAuthUri: string
}

const AccountConfigViewHoc = (props: AccountConfigViewHocProps) => {
  const account: serialized_account = json_to<serialized_account>(props.account);

  return (
    <ThemeProvider theme={adminPalette}>
      <StreamingAuthorizationView account={account} spotifyAuthUri={props.spotifyAuthUri}/>
    </ThemeProvider>
  )
}

export default AccountConfigViewHoc
