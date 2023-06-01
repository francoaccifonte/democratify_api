import React from 'react'
import { act, render, fireEvent, getByText } from '@testing-library/react'
import '@testing-library/jest-dom'

import { List } from '../../../../app/javascript/components/views/spotify_playlists/selection'
import { SerializedSpotifyPlaylistFactory } from '../../factories/serialized_spotify_playlist_factory'

const fixture = [SerializedSpotifyPlaylistFactory(), SerializedSpotifyPlaylistFactory()]
fixture[1].id += 1
fixture[1].name = `${fixture[1].name}_dos`

describe('List', () => {
  it('renders a list of playlists', async () => {
    const subject = render(<List playlists={fixture}/>)

    expect(subject.getByText(fixture[0].name)).toBeInTheDocument()
    expect(subject.getByText(fixture[1].name)).toBeInTheDocument()
  })
})
