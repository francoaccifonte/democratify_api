import React from 'react';
import { act, render, fireEvent, getByText } from '@testing-library/react';
import '@testing-library/jest-dom'

import { SpotifyLoginButton } from '../../../../app/javascript/components/views/account_config';
import { serialized_account, serialized_spotify_user } from '../../../../app/javascript/components/types';

describe('SpotifyLoginButton', () => {
  it('has an available link to the correct place', async () => {
    const account: serialized_account = { id: 1, created_at: new Date(), updated_at: new Date(), spotify_users: [] }
    const subject = render(<SpotifyLoginButton account={account} authUri='http://link.to.somewhere' />);

    expect(subject.getByRole('button')).toBeInTheDocument();
    expect(subject.getByRole('button')).toBeEnabled();
    expect(subject.getByRole('button')).toHaveAttribute('href', 'http://link.to.somewhere')
  })

  it('is disabled if already linked', async () => {
    const spotify_user: serialized_spotify_user = { id: 1, created_at: new Date(), updated_at: new Date()}
    const account: serialized_account = {
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
