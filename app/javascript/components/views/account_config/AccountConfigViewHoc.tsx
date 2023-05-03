import React from 'react'
import withStyles, { ThemeProvider } from 'react-jss'

import { StreamingAuthorizationView } from '.'
import { adminPalette } from '../../ColorPalette'
import { serialized_account, json_to } from '../../types'

type AccountConfigViewHocProps = {
  account: string
}

const AccountConfigViewHoc = (props: AccountConfigViewHocProps) => {
  const account: serialized_account = json_to<serialized_account>(props.account);

  return (
    <ThemeProvider theme={adminPalette}>
      <StreamingAuthorizationView account={account}/>
    </ThemeProvider>
  )
}

export default AccountConfigViewHoc
