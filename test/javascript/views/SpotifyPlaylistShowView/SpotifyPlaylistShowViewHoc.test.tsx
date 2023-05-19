/* eslint-disable no-unused-expressions */
/* eslint-disable camelcase */
import React from 'react'
import { act, render, fireEvent, getByText } from '@testing-library/react'
import '@testing-library/jest-dom'

import { SpotifyPlaylistShowViewHoc } from '../../../../app/javascript/components/views/spotify_playlists/selection'
import { serialized_account_fixture, serialized_spotify_playlist_fixture } from '../../factories'
import { toJson } from '../../../../app/javascript/components/types'
import client, { OngoingPlaylistModel } from '../../../../app/javascript/requests/'

const fixture = serialized_spotify_playlist_fixture()

describe('List', () => {
  it('renders a list of playlists', async () => {
    const subject = render(<SpotifyPlaylistShowViewHoc playlist={toJson(fixture)} account={toJson(serialized_account_fixture())} />)

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
      const subject = render(<SpotifyPlaylistShowViewHoc playlist={toJson(fixture)} account={toJson(serialized_account_fixture())} />)

      await act(async () => fireEvent.click(subject.getByText('Reproducir')))

      expect(mockedInstance.start).toHaveBeenCalledWith(fixture.id)
    })
  })
})
