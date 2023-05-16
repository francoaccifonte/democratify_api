import React from 'react';
import { act, render, fireEvent, getByText } from '@testing-library/react';
import '@testing-library/jest-dom'

import { PlaylistCard } from '../../../../app/javascript/components/views/spotify_playlists/selection';
import { serialized_spotify_playlist_fixture } from '../../factories/serialized_spotify_playlist_factory';

describe('PlaylistCard', () => {
  it('when failedAuth is undefined shows the login form and sends the request', async () => {
    const playlist = serialized_spotify_playlist_fixture()
    const subject = render(<PlaylistCard playlist={playlist} />);

    expect(subject.getByText(playlist.name)).toBeInTheDocument();

    const link = subject.getByRole('link', { name: playlist.name })
    expect(link).toBeInTheDocument;
    expect(link).toHaveAttribute('href', `/spotify_playlists/${playlist.id}`);

    const img = subject.getByRole('img')
    expect(img).toBeInTheDocument();
    expect(img).toHaveAttribute('src', playlist.cover_art_url)
  });
});
