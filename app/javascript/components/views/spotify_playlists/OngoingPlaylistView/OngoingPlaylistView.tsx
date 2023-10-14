import React, { useContext, useState } from 'react'
import Container from 'react-bootstrap/Container'

import { serializedAccount, serializedOngoingPlaylist, serializedVotation } from '../../../types'
import { Player, SongList } from './'
import { FullHeightSkeleton, QR } from '../../../common'
import { ResponsiveContext } from '../../contexts'

type OngoingPlaylistViewProps = {
  account: serializedAccount;
  votation: serializedVotation;
  ongoingPlaylist: serializedOngoingPlaylist;
}

const OngoingPlaylistView: React.FC<OngoingPlaylistViewProps> = (props) => {
  const device = useContext(ResponsiveContext)
  const [poolSize, setPoolSize] = useState<number>(props.ongoingPlaylist.pool_size)
  const poolControls = {
    incrementPoolSize: () => { setPoolSize(Math.min(poolSize + 1, props.ongoingPlaylist.remaining_songs.length)) },
    decrementPoolSize: () => { setPoolSize(Math.max(poolSize - 1, 2)) },
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
          { !device.isMobile &&
          <Container style={{ width: '40%' }}>
            <Player ongoingPlaylist={props.ongoingPlaylist} poolControls={poolControls}/>
            <QR accountId={props.account.id}/>
          </Container>
          }
        <Container>
          <SongList ongoingPlaylist={props.ongoingPlaylist} poolControls={poolControls}/>
        </Container>
      </FullHeightSkeleton>
    </>
  )
}

export default OngoingPlaylistView
