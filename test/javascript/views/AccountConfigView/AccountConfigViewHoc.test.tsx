import React from 'react'
import { render } from '@testing-library/react'
import '@testing-library/jest-dom'

import { AccountConfigViewHoc } from '../../../../app/javascript/components/views'
import { serializedAccount, toJson } from '../../../../app/javascript/components/types'
import { SerializedAccountFactory } from '../../factories'

describe('AccountConfigViewHoc', () => {
  it('renders correctly', async () => {
    const account: serializedAccount = SerializedAccountFactory()
    const subject = render(<AccountConfigViewHoc account={toJson(account)} spotifyAuthUri='http://link.to.somewhere' />)

    expect(subject.getByText('Spotify')).toBeInTheDocument()
    expect(subject.getByText('Youtube')).toBeInTheDocument()
    expect(subject.getByText('Proximamente')).toBeInTheDocument()
  })
})
