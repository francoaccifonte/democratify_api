import React from 'react'
import { act, render, fireEvent, getByText } from '@testing-library/react'
import '@testing-library/jest-dom'

import { SpotifyPlaylistSelectionViewHoc } from '../../../../app/javascript/components/views/spotify_playlists/selection'
import { SerializedAccountFactory, SerializedSpotifyPlaylistFactory } from '../../factories'
import { serializedAccount, toJson } from '../../../../app/javascript/components/types'

const fixture = [SerializedSpotifyPlaylistFactory(), SerializedSpotifyPlaylistFactory()]
fixture[1].id += 1
fixture[1].name = `${fixture[1].name}_dos`

describe('List', () => {
  it('renders a list of playlists', async () => {
    const subject = render(<SpotifyPlaylistSelectionViewHoc playlists={toJson(fixture)} account={toJson(SerializedAccountFactory())} />)

    expect(subject.getByText(fixture[0].name)).toBeInTheDocument()
    expect(subject.getByText(fixture[1].name)).toBeInTheDocument()
  })
})
