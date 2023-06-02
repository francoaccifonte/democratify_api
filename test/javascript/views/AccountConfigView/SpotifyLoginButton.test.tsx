import React from 'react'
import { render } from '@testing-library/react'
import '@testing-library/jest-dom'

import { SpotifyLoginButton } from '../../../../app/javascript/components/views/account_config'
import { serializedAccount, serializedSpotifyUser } from '../../../../app/javascript/components/types'
import { SerializedAccountFactory } from '../../factories'

describe('SpotifyLoginButton', () => {
  it('has an available link to the correct place', async () => {
    const account = SerializedAccountFactory()
    const subject = render(<SpotifyLoginButton account={account} authUri='http://link.to.somewhere' />)

    expect(subject.getByRole('button')).toBeInTheDocument()
    expect(subject.getByRole('button')).toBeEnabled()
    expect(subject.getByRole('button')).toHaveAttribute('href', 'http://link.to.somewhere')
  })

  it('is disabled if already linked', async () => {
    const spotifyUser: serializedSpotifyUser = { id: 1, created_at: new Date(), updated_at: new Date() }
    const account: serializedAccount = {
      id: 1,
      created_at: new Date(),
      updated_at: new Date(),
      spotify_user: spotifyUser
    }
    const subject = render(<SpotifyLoginButton account={account} authUri='http://link.to.somewhere' />)

    expect(subject.getByRole('button')).toBeInTheDocument()
    expect(subject.getByRole('button')).toHaveAttribute('href', 'http://link.to.somewhere')
    expect(subject.getByRole('button')).toHaveAttribute('aria-disabled', 'true')
  })
})
