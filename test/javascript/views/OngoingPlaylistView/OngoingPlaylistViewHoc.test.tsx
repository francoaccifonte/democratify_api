import React from 'react'
import { act, render, fireEvent, getByText } from '@testing-library/react'
import '@testing-library/jest-dom'

import { OngoingPlaylistViewHoc } from '../../../../app/javascript/components/views'
import { toJson, serializedAccount, serializedOngoingPlaylist, serializedVotation } from '../../../../app/javascript/components/types'

const account: serializedAccount = { id: 1, created_at: new Date(), updated_at: new Date() }
const ongoingPlaylist: serializedOngoingPlaylist = 

describe('OngoingPlaylistViewHoc', () => {
  describe('when there is an ongoing playlist', () => {
    it('renders correctly', async () => {
      const subject = render(<OngoingPlaylistViewHoc account={toJson(account)} />)

      expect(subject.getByText('Spotify')).toBeInTheDocument()
      expect(subject.getByText('Youtube')).toBeInTheDocument()
      expect(subject.getByText('Proximamente')).toBeInTheDocument()
    })
  })
})
