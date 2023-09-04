import React from 'react'
import { render } from '@testing-library/react'
import '@testing-library/jest-dom'
import { QR } from '../../../app/javascript/components/common/'

describe('OngoingPlaylistViewHoc', () => {
  describe('when there is an ongoing playlist', () => {
    it('playing, voting and remaining songs', async () => {
      const subject = render(<QR accountId={1} />)
      subject.debug()
      expect(subject.getByRole('img')).toHaveAttribute('src', 'https://chart.googleapis.com/chart?cht=qr&chs=300x300&chl=https://rockolify.holasoyfranco.com/account/1/votation')
    })
  })
})
