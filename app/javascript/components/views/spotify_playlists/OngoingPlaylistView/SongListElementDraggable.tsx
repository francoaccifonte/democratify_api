import React from 'react'
import { Draggable } from 'react-beautiful-dnd'

import { SongListElement } from './'
import { serializedSpotifySong } from '../../../types'

type songListProps = {
rowNumber: number;
  data: serializedSpotifySong;
  index: number;
  poolSize: number;
}

const SongListElementDraggable: React.FC<songListProps> = ({ rowNumber, data, index, poolSize }): JSX.Element => {
  return (
    <Draggable key={index.toString()} draggableId={index.toString()} index={index} >
      {(provided, snapshot) => {
        return (
          <div {...provided.draggableProps} ref={provided.innerRef} {...provided.dragHandleProps}>
            <SongListElement rowNumber={rowNumber} data={data} poolSize={poolSize}/>
          </div>
        )
      }}
    </Draggable>
  )
}

export default SongListElementDraggable
