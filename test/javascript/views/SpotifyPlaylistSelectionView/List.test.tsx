import React from 'react'
import { render } from '@testing-library/react'
import '@testing-library/jest-dom'

import { List } from '../../../../app/javascript/components/views/spotify_playlists/selection'
import { SerializedSpotifyPlaylistFactory } from '../../factories/SerializedSpotifyPlaylistFactory'
import { buildList } from '../../factories'

const playlist = buildList(SerializedSpotifyPlaylistFactory, 2)

describe('List', () => {
  it('renders a list of playlists', async () => {
    const subject = render(<List playlists={playlist}/>)

    expect(subject.getByText(playlist[0].name)).toBeInTheDocument()
    expect(subject.getByText(playlist[1].name)).toBeInTheDocument()
  })
})
