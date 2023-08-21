import React from 'react'
import { render } from '@testing-library/react'
import '@testing-library/jest-dom'

import { SpotifyPlaylistSelectionView } from '../../../../app/javascript/components/views/spotify_playlists/selection'
import { SerializedAccountFactory, SerializedSpotifyPlaylistFactory, buildList } from '../../factories'

const playlists = buildList(SerializedSpotifyPlaylistFactory, 2)
const account = SerializedAccountFactory()

describe('SerializedAccountFactory', () => {
  it('renders a list of playlists', async () => {
    const subject = render(<SpotifyPlaylistSelectionView playlists={playlists} account={account} importInProgress={false}/>)

    expect(subject.getByText(playlists[0].name)).toBeInTheDocument()
    expect(subject.getByText(playlists[1].name)).toBeInTheDocument()
  })

  it('shows a message when there are no available playlists', () => {
    const subject = render(<SpotifyPlaylistSelectionView playlists={[]} account={account} importInProgress={false}/>)

    expect(subject.queryByText(playlists[0].name)).toBeNull()
    expect(subject.queryByText(playlists[1].name)).toBeNull()

    expect(subject.getByText('No se encontraron playlists.')).toBeInTheDocument()
    expect(subject.getByText('Haz click para importarlas desde tu cuenta de Spotify')).toBeInTheDocument()
  })

  it('shows a message there is an import in progress', () => {
    const subject = render(<SpotifyPlaylistSelectionView playlists={[]} account={account} importInProgress={true}/>)

    expect(subject.getByText('Esta lista podria estar incpompleta ya que estamos importando tus playlists')).toBeInTheDocument()
  })
})
