import React from 'react'

import Hoc, { HocPropsType } from '../../../common/Hoc'
import { jsonTo, serializedAccount, serializedOngoingPlaylist, serializedVotation } from '../../../types'
import { OngoingPlaylistView } from './'

type OngoingPlaylistViewHocProps = {
  account: string;
  ongoingPlaylist: string;
  votation: string;
} & HocPropsType

const OngoingPlaylistViewHoc: React.FC<OngoingPlaylistViewHocProps> = (props): JSX.Element => {
  const account: serializedAccount = jsonTo<serializedAccount>(props.account)
  const ongoingPlaylist: serializedOngoingPlaylist = jsonTo<serializedOngoingPlaylist>(props.ongoingPlaylist)
  const votation: serializedVotation = jsonTo<serializedVotation>(props.votation)

  return (
    <Hoc {...props}>
      <OngoingPlaylistView account={account} ongoingPlaylist={ongoingPlaylist} votation={votation}/>
    </Hoc>
  )
}

export default OngoingPlaylistViewHoc
