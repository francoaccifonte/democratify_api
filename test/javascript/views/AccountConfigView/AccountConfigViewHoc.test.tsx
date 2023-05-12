import React from 'react';
import { act, render, fireEvent, getByText } from '@testing-library/react';
import '@testing-library/jest-dom'

import { AccountConfigViewHoc } from "../../../../app/javascript/components/views";
import { serialized_account, serialized_spotify_user, to_json } from '../../../../app/javascript/components/types';

describe("AccountConfigViewHoc", () => {
  it("renders correctly", async () => {
    const account: serialized_account = { id: 1, created_at: new Date(), updated_at: new Date(), spotify_users: [] }
    const subject = render(<AccountConfigViewHoc account={to_json(account)} spotifyAuthUri='http://link.to.somewhere' />);

    expect(subject.getByText('Spotify')).toBeInTheDocument();
    expect(subject.getByText('Youtube')).toBeInTheDocument();
    expect(subject.getByText('Proximamente')).toBeInTheDocument();
  })
})
