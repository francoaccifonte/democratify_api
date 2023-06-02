import React from 'react'
import { render } from '@testing-library/react'
import '@testing-library/jest-dom'

import { PlaylistCard } from '../../../../app/javascript/components/views/spotify_playlists/selection'
import { SerializedSpotifyPlaylistFactory } from '../../factories/SerializedSpotifyPlaylistFactory'

describe('PlaylistCard', () => {
  it('when failedAuth is undefined shows the login form and sends the request', async () => {
    const playlist = SerializedSpotifyPlaylistFactory()
    const subject = render(<PlaylistCard playlist={playlist} />)

    expect(subject.getByText(playlist.name)).toBeInTheDocument()

    const link = subject.getByRole('link', { name: playlist.name })
    expect(link).toBeInTheDocument()
    expect(link).toHaveAttribute('href', `/spotify_playlists/${playlist.id}`)

    const img = subject.getByRole('img')
    expect(img).toBeInTheDocument()
    expect(img).toHaveAttribute('src', playlist.cover_art_url)
  })
})
