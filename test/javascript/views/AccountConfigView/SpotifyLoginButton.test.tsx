import React from 'react';
import { act, render, fireEvent, getByText } from '@testing-library/react';
import '@testing-library/jest-dom'

import { SpotifyLoginButton } from '../../../../app/javascript/components/views/account_config';
import { serializedAccount, serializedSpotifyUser } from '../../../../app/javascript/components/types';

describe('SpotifyLoginButton', () => {
  it('has an available link to the correct place', async () => {
    const account: serializedAccount = { id: 1, created_at: new Date(), updated_at: new Date(), spotify_users: [] }
    const subject = render(<SpotifyLoginButton account={account} authUri='http://link.to.somewhere' />);

    expect(subject.getByRole('button')).toBeInTheDocument();
    expect(subject.getByRole('button')).toBeEnabled();
    expect(subject.getByRole('button')).toHaveAttribute('href', 'http://link.to.somewhere')
  })

  it('is disabled if already linked', async () => {
    const spotify_user: serializedSpotifyUser = { id: 1, created_at: new Date(), updated_at: new Date()}
    const account: serializedAccount = {
      id: 1,
      created_at: new Date(),
      updated_at: new Date(),
      spotify_users: [spotify_user] }
    const subject = render(<SpotifyLoginButton account={account} authUri='http://link.to.somewhere' />);

    expect(subject.getByRole('button')).toBeInTheDocument();
    expect(subject.getByRole('button')).toHaveAttribute('href', 'http://link.to.somewhere')
    expect(subject.getByRole('button')).toHaveAttribute('aria-disabled', "true");
  })
});
