import React from 'react'
import { render } from '@testing-library/react'
import '@testing-library/jest-dom'

import { SpotifyPlaylistSelectionViewHoc } from '../../../../app/javascript/components/views/spotify_playlists/selection'
import { SerializedAccountFactory, SerializedSpotifyPlaylistFactory, buildList } from '../../factories'
import { toJson } from '../../../../app/javascript/components/types'

const playlist = buildList(SerializedSpotifyPlaylistFactory, 2)

describe('List', () => {
  it('renders a list of playlists', async () => {
    const subject = render(<SpotifyPlaylistSelectionViewHoc playlists={toJson(playlist)} account={toJson(SerializedAccountFactory())} import_in_progress={false}/>)

    expect(subject.getByText(playlist[0].name)).toBeInTheDocument()
    expect(subject.getByText(playlist[1].name)).toBeInTheDocument()
  })
})
