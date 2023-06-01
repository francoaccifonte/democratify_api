import React, { useState } from 'react'
import Container from 'react-bootstrap/Container'
import { DragDropContext, Droppable } from 'react-beautiful-dnd'
import withStyles from 'react-jss'

import { SongListElementDraggable, PlayingSong, VotingSongs } from './'
import { serializedOngoingPlaylist, serializedSpotifySong } from '../../../types'
import { adminPalette } from '../../../ColorPalette'
import client from '../../../../requests/index'

type SongListProps = {
  ongoingPlaylist: serializedOngoingPlaylist;
  poolControls: {
    incrementPoolSize: Function;
    decrementPoolSize: Function;
    poolSize: number
  };
  classes: any;
}

const SongList: React.FC<SongListProps> = ({ ongoingPlaylist, poolControls, classes }): JSX.Element => {
  let timerId: any
  const [playingSong, votingSongs] = [ongoingPlaylist.playing_song, ongoingPlaylist.voting_songs]
  const [remainingSongs, setRemainingSongs] = useState<serializedSpotifySong[]>(ongoingPlaylist.remaining_songs)

  const handleDragEnd = (result) => {
    if (!(result && result.source && result.destination)) { return }

    const items = Array.from(remainingSongs)
    const from = result.source.index
    const to = result.destination.index
    const [reorderedItem] = items.splice(from, 1)
    items.splice(to, 0, reorderedItem)

    setRemainingSongs(items)
    if (timerId) { clearTimeout(timerId) }
    timerId = setTimeout(async () => {
      const { id } = ongoingPlaylist
      const candidatePoolSize = poolControls.poolSize
      const response = await client.ongoingPlaylist.reorder(id, remainingSongs, candidatePoolSize)
      console.log(response)
      // return response.json()
    }, 3000)
  }

  if (!ongoingPlaylist.id) {
    return (
      <div>
        404
      </div>
    )
  }

  return (
    <Container className={classes.container}>
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

const style = (theme: typeof adminPalette) => {
  return {
    container: {
      overflowX: 'hidden',
      overflowY: 'scroll',
      height: '100%'
    }
  }
}

export default withStyles(style)(SongList)
