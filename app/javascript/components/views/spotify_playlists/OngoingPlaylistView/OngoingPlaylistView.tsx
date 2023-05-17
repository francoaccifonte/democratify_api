import React, { useState } from 'react'
import Container from 'react-bootstrap/Container'

import { serializedAccount, serializedOngoingPlaylist, serializedSpotifyPlaylist, serializedVotation } from '../../../types'
import { Player, SongList } from './'
import { FullHeightSkeleton } from '../../../common'

type OngoingPlaylistViewProps = {
  account: serializedAccount;
  playlist: serializedSpotifyPlaylist;
  votation: serializedVotation;
  ongoingPlaylist: serializedOngoingPlaylist;
}

const OngoingPlaylistView: React.FC<OngoingPlaylistViewProps> = (props) => {
  const [poolSize, setPoolSize] = useState<number>(props.ongoingPlaylist.pool_size)
  const poolControls = {
    incrementPoolSize: () => { setPoolSize(poolSize + 1) },
    decrementPoolSize: () => { setPoolSize(Math.max(poolSize - 1, 0)) },
    poolSize
  }

  // TODO: this should be timed for the ending of the votation
  // useEffect(() => {
  //   if (ongoingPlaylist.status === 'fulfilled' && ongoingPlaylist.id) {
  //     const interval2 = setInterval(() => {
  //       reloadOngoingPlaylist()
  //     }, 3000)
  //     return () => clearInterval(interval2)
  //   }
  // }, [ongoingPlaylist.id, ongoingPlaylist.status])

  return (
    <>
      <FullHeightSkeleton header palette='admin' overflowY="hidden">
        <Container style={{ width: '40%' }}>
          <Player ongoingPlaylist={props.ongoingPlaylist} poolControls={poolControls}/>
        </Container>
        <Container>
          <SongList ongoingPlaylist={props.ongoingPlaylist} poolControls={poolControls}/>
        </Container>
      </FullHeightSkeleton>
    </>
  )
}

export default OngoingPlaylistView
