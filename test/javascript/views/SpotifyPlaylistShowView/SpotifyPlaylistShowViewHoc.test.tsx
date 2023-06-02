/* eslint-disable camelcase */
import React from 'react'
import { act, render, fireEvent } from '@testing-library/react'
import '@testing-library/jest-dom'

import { SpotifyPlaylistShowViewHoc } from '../../../../app/javascript/components/views/spotify_playlists/selection'
import { SerializedAccountFactory, SerializedSpotifyPlaylistFactory } from '../../factories'
import { toJson } from '../../../../app/javascript/components/types'
import client, { OngoingPlaylistModel } from '../../../../app/javascript/requests/'

const spotifyPlaylist = SerializedSpotifyPlaylistFactory()
const account = SerializedAccountFactory()

describe('Show', () => {
  it('renders a single playlist', async () => {
    const subject = render(<SpotifyPlaylistShowViewHoc playlist={toJson(spotifyPlaylist)} account={toJson(account)} />)

    spotifyPlaylist.spotify_songs.forEach((song) => {
      expect(subject.getByText(song.title)).toBeInTheDocument()
    })
  })

  it('renders the controls', async () => {
    const subject = render(<SpotifyPlaylistShowViewHoc playlist={toJson(spotifyPlaylist)} account={toJson(account)} />)

    const img = subject.getByRole('img')
    expect(img).toBeInTheDocument()
    expect(img).toHaveAttribute('src', spotifyPlaylist.cover_art_url)
  })

  describe('When starting a playlist', () => {
    it('triggers a request', async () => {
      const mockedInstance = {
        start: jest.fn()
      }
      mockedInstance.start.mockReturnValue({
        status: 200,
        json: new Promise((resolve, reject) => resolve({ id: 1 }))
      })
      client.ongoingPlaylist = mockedInstance as unknown as OngoingPlaylistModel
      const subject = render(<SpotifyPlaylistShowViewHoc playlist={toJson(spotifyPlaylist)} account={toJson(account)} />)

      await act(async () => fireEvent.click(subject.getByText('Reproducir')))

      expect(mockedInstance.start).toHaveBeenCalledWith(spotifyPlaylist.id)
      expect(subject.queryByText('No encontramos ningun dispositivo en spotify')).not.toBeInTheDocument()
    })

    it('shows an error message when status code is 400', async () => {
      const mockedInstance = {
        start: jest.fn()
      }
      mockedInstance.start.mockReturnValue({
        status: 400,
        json: new Promise((resolve, reject) => resolve({ id: 1 }))
      })
      client.ongoingPlaylist = mockedInstance as unknown as OngoingPlaylistModel
      const subject = render(<SpotifyPlaylistShowViewHoc playlist={toJson(spotifyPlaylist)} account={toJson(account)} />)

      await act(async () => fireEvent.click(subject.getByText('Reproducir')))

      expect(subject.getByText('No encontramos ningun dispositivo en spotify')).toBeInTheDocument()
    })
  })
})
