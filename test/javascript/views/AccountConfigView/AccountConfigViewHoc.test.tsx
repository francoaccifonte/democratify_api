import React from 'react';
import { act, render, fireEvent, getByText } from '@testing-library/react';
import '@testing-library/jest-dom'

import { AccountConfigViewHoc } from "../../../../app/javascript/components/views";
import { serializedAccount, serializedSpotifyUser, toJson } from '../../../../app/javascript/components/types';

describe("AccountConfigViewHoc", () => {
  it("renders correctly", async () => {
    const account: serializedAccount = { id: 1, created_at: new Date(), updated_at: new Date(), spotify_users: [] }
    const subject = render(<AccountConfigViewHoc account={toJson(account)} spotifyAuthUri='http://link.to.somewhere' />);

    expect(subject.getByText('Spotify')).toBeInTheDocument();
    expect(subject.getByText('Youtube')).toBeInTheDocument();
    expect(subject.getByText('Proximamente')).toBeInTheDocument();
  })
})
