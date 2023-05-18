import React from 'react'
import Container from 'react-bootstrap/Container'
import { DragDropContext, Droppable } from 'react-beautiful-dnd'
import CSS from 'csstype'

import { SongListElementDraggable, PlayingSong, VotingSongs } from './'
import { serializedOngoingPlaylist } from '../../../types'

type SongListProps = {
  ongoingPlaylist: serializedOngoingPlaylist;
  poolControls: any;
}

const SongList: React.FC<SongListProps> = ({ ongoingPlaylist, poolControls }): JSX.Element => {
  const songListStyle: CSS.Properties = {
    overflowX: 'hidden',
    overflowY: 'scroll',
    height: '100%'
  }

  // let timerId: any
  const [playingSong, votingSongs, remainingSongs] = [ongoingPlaylist.playing_song, ongoingPlaylist.voting_songs, ongoingPlaylist.remaining_songs]

  const handleDragEnd = (result: any) => {
    if (!(result && result.source && result.destination)) { return }

    const items = Array.from(remainingSongs)
    const from = result.source.index
    const to = result.destination.index
    const [reorderedItem] = items.splice(from, 1)
    items.splice(to, 0, reorderedItem)

    // dispatch(parseFromPlaylistReorderer(items))
    // if (timerId) { clearTimeout(timerId) }
    // timerId = setTimeout(() => {
    //   dispatch(updateInBackend({ songs: items }))
    // }, 3000)
  }

  if (!ongoingPlaylist.id) {
    return (
      <div>
        404
      </div>
    )
  }

  return (
    <Container style={songListStyle}>
      <PlayingSong song={playingSong} />
      <VotingSongs songs={votingSongs} />
      <DragDropContext onDragEnd={handleDragEnd}>
        <Droppable droppableId="songs">
          {(provided, snapshot) => {
            return (
              <div className="songs" {...provided.droppableProps} ref={provided.innerRef}>
                {
                  remainingSongs.map((data, id) => {
                    return (
                      <SongListElementDraggable rowNumber={id} data={data} index={id} key={id} poolSize={poolControls.poolSize}/>
                    )
                  })
                }
                {provided.placeholder}
              </div>
            )
          }}
        </Droppable>
      </DragDropContext>
    </Container>
  )
}

export default SongList
