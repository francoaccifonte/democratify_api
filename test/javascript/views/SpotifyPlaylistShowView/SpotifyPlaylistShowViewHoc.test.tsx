/* eslint-disable no-unused-expressions */
/* eslint-disable camelcase */
// TODO: this test is repeated, unify it: test/javascript/views/SpotifyPlaylistSelectionView/SpotifyPlaylistShowViewHoc.test.tsx
import React from 'react'
import { act, render, fireEvent, getByText } from '@testing-library/react'
import '@testing-library/jest-dom'

import { SpotifyPlaylistShowViewHoc } from '../../../../app/javascript/components/views/spotify_playlists/selection'
import { SerializedAccountFactory, SerializedSpotifyPlaylistFactory } from '../../factories'
import { toJson } from '../../../../app/javascript/components/types'
import client, { OngoingPlaylistModel } from '../../../../app/javascript/requests/'

const fixture = SerializedSpotifyPlaylistFactory()

describe('List', () => {
  it('renders a list of playlists', async () => {
    const subject = render(<SpotifyPlaylistShowViewHoc playlist={toJson(fixture)} account={toJson(SerializedAccountFactory())} />)

    fixture.spotify_songs.forEach((song) => {
      expect(subject.getByText(song.title)).toBeInTheDocument
    })
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
      const subject = render(<SpotifyPlaylistShowViewHoc playlist={toJson(fixture)} account={toJson(SerializedAccountFactory())} />)

      await act(async () => fireEvent.click(subject.getByText('Reproducir')))

      expect(mockedInstance.start).toHaveBeenCalledWith(fixture.id)
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
      const subject = render(<SpotifyPlaylistShowViewHoc playlist={toJson(fixture)} account={toJson(SerializedAccountFactory())} />)

      await act(async () => fireEvent.click(subject.getByText('Reproducir')))

      expect(subject.getByText('No encontramos ningun dispositivo en spotify')).toBeInTheDocument
    })
  })
})
