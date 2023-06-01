import React from 'react'
import { act, render, fireEvent, getByText } from '@testing-library/react'
import '@testing-library/jest-dom'

import { SpotifyPlaylistShowViewHoc } from '../../../../app/javascript/components/views/spotify_playlists/selection'
import { buildList, SerializedAccountFactory, SerializedSpotifyPlaylistFactory, SerializedSpotifySongFactory } from '../../factories'
import { toJson } from '../../../../app/javascript/components/types'

const fixture = SerializedSpotifyPlaylistFactory()
fixture.spotify_songs = buildList(SerializedSpotifySongFactory, 3)

describe('List', () => {
  it('renders a playlist', async () => {
    const subject = render(<SpotifyPlaylistShowViewHoc playlist={toJson(fixture)} account={toJson(SerializedAccountFactory())} />)

    for (let i = 0; i < fixture.spotify_songs.length; i++) {
      expect(subject.getByText(fixture.spotify_songs[i].title)).toBeInTheDocument()
    }
  })

  it('renders the controls', async () => {
    const subject = render(<SpotifyPlaylistShowViewHoc playlist={toJson(fixture)} account={toJson(SerializedAccountFactory())} />)

    const img = subject.getByRole('img')
    expect(img).toBeInTheDocument()
    expect(img).toHaveAttribute('src', fixture.cover_art_url)
  })
})
