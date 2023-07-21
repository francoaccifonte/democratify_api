import React from 'react'
import { render } from '@testing-library/react'
import '@testing-library/jest-dom'

import { SpotifyLoginButton } from '../../../../app/javascript/components/views/account_config'
import { serializedAccount, serializedSpotifyUser } from '../../../../app/javascript/components/types'
import { SerializedAccountFactory, SerializedSpotifyUserFactory } from '../../factories'

describe('SpotifyLoginButton', () => {
  it('has an available link to the correct place', async () => {
    const account = SerializedAccountFactory()
    const subject = render(<SpotifyLoginButton account={account} authUri='http://link.to.somewhere' />)

    expect(subject.getByRole('button')).toBeInTheDocument()
    expect(subject.getByRole('button')).toBeEnabled()
    expect(subject.getByRole('button')).toHaveAttribute('href', 'http://link.to.somewhere')
  })

  it('is disabled if already linked', async () => {
    const spotifyUser: serializedSpotifyUser = SerializedSpotifyUserFactory()
    const account: serializedAccount = SerializedAccountFactory()
    account.spotify_user = spotifyUser
    const subject = render(<SpotifyLoginButton account={account} authUri='http://link.to.somewhere' />)

    expect(subject.getByText('Vinculado con exito!')).toBeInTheDocument()
  })
})
