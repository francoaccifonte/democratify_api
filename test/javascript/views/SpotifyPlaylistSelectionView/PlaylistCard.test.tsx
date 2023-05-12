import React from 'react';
import { act, render, fireEvent, getByText } from '@testing-library/react';
import '@testing-library/jest-dom'

import { PlaylistCard } from '../../../../app/javascript/components/views/spotify_playlists/selection';
import { serialized_spotify_playlist_fixture } from '../../fixtures/serialized_spotify_playlist_fixture';

describe('PlaylistCard', () => {
  it('when failedAuth is undefined shows the login form and sends the request', async () => {
    const subject = render(<PlaylistCard playlist={serialized_spotify_playlist_fixture} />);

    expect(subject.getByText(serialized_spotify_playlist_fixture.name)).toBeInTheDocument();

    const link = subject.getByRole('link', { name: serialized_spotify_playlist_fixture.name })
    expect(link).toBeInTheDocument;
    expect(link).toHaveAttribute('href', `/playlists/${serialized_spotify_playlist_fixture.id}`);

    const img = subject.getByRole('img')
    expect(img).toBeInTheDocument();
    expect(img).toHaveAttribute('src', serialized_spotify_playlist_fixture.cover_art_url)
  });
});
