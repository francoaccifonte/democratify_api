import React from 'react'
import { act, render, fireEvent, getByText } from '@testing-library/react'
import '@testing-library/jest-dom'

import { OngoingPlaylistViewHoc } from '../../../../app/javascript/components/views'
import { toJson, serializedAccount, serializedOngoingPlaylist, serializedVotation } from '../../../../app/javascript/components/types'
import { serializedOngoingPlaylistFactory } from '../../factories'
import { serializedVotationFactory } from '../../factories/SerializedVotationFactory'

const account: serializedAccount = { id: 1, created_at: new Date(), updated_at: new Date() }
const ongoingPlaylist: serializedOngoingPlaylist = serializedOngoingPlaylistFactory()
const votation: serializedVotation = serializedVotationFactory()

describe('OngoingPlaylistViewHoc', () => {
  describe('when there is an ongoing playlist', () => {
    it('playing, voting and remaining songs', async () => {
      const subject = render(<OngoingPlaylistViewHoc votation={toJson(votation)} ongoingPlaylist={toJson(ongoingPlaylist)} account={toJson(account)} />)

      expect(subject.getByText(ongoingPlaylist.playing_song.title)).toBeInTheDocument()
      votation.votation_candidates.forEach((value) => {
        expect(subject.getAllByText(value.spotify_song.title)[0]).toBeInTheDocument()
      })
      ongoingPlaylist.remaining_songs.forEach((value) => {
        expect(subject.getAllByText(value.title)[0]).toBeInTheDocument()
      })
    })
  })
})
