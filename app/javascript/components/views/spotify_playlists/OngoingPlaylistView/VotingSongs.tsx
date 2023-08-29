import React, { useContext } from 'react'

import { serializedSpotifySong } from '../../../types'
import VotingSong from './VotingSong'
import { FooterContext } from '../../contexts'

type VotingSongsProps = {
  songs?: serializedSpotifySong[];
}

const VotingSongs = (props: VotingSongsProps) => {
  const { votation } = useContext(FooterContext)
  if (!votation.votation_candidates) { return null }

  const totalVotes = votation.votation_candidates.reduce((accumulator, a) => accumulator + a.votes, 0)

  return (
    <>
      {
        votation.votation_candidates.map((song, index) => {
          return (
          <div key={`VotingSong-${index}`}>
            <VotingSong song={song} totalVotes={totalVotes}/>
          </div>
          )
        })
      }
    </>
  )
}

export default VotingSongs
