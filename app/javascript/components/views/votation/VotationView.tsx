import React, { useContext, useState } from 'react'
import Container from 'react-bootstrap/Container'
import Row from 'react-bootstrap/Row'
import Button from 'react-bootstrap/Button'
import moment from 'moment'
import { ThemeProvider } from 'react-jss'

import { Text, FullHeightSkeleton } from '../../common'
import { userPalette } from '../../ColorPalette'
import { CandidateElement } from '.'
import { FooterContext } from '../contexts/FooterContext'

type VotationViewParams = {};

const VotationView: React.FC<VotationViewParams> = (params): JSX.Element => {
  const [selected, setSelected] = useState<number|undefined>(undefined)
  const { votation } = useContext(FooterContext)

  // https://www.npmjs.com/package/clientjs
  // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  // Implement fingerprinting from that package!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  const voteAlreadyCasted = false // previousVotationIds.includes(String(votationState.votation.id))

  const handleVote = async (id: number) => {
    // TODO
  }
  const handleSelectCandidate = (id: number) => {
    // if (!voteAlreadyCasted) { setSelected(id) }
    setSelected(id)
  }

  if (!votation) {
    return <div>No hay una playlist en curso</div>
  }

  const candidates = votation.votation_candidates

  const Candidates = () => {
    return (
      <Container style={{ overflowY: 'auto' }}>
          {
            candidates?.map((candidate, index) => {
              return (
                <CandidateElement data={candidate} key={index} selected={selected} disabled={voteAlreadyCasted} onSelect={() => handleSelectCandidate(candidate.id)} />
              )
            })
          }
      </Container>
    )
  }

  const VoteButton = () => {
    if (selected) {
      return (
        <Container fluid>
          <Row>
            <Button className="mb-3 mt-3" onClick={() => handleVote(selected)} style={{ backgroundColor: userPalette.Info, borderColor: userPalette.Info }}>Votar</Button>
          </Row>
        </Container>
      )
    } else {
      return <Button className="mb-3 mt-3" disabled>Votar</Button>
    }
  }

  const VotationTimer = () => {
    if (voteAlreadyCasted) {
      return (
       <Text type="bodyRegular" >
          {`Votacion termina en ${moment.utc(moment(votation.scheduled_close_for).diff(moment())).format('mm:ss')}`}
        </Text>
      )
    }
    return null
  }

  return (
    <ThemeProvider theme={userPalette}>
      <FullHeightSkeleton header palette='user' flexDirectionColumn overflowY="hidden">
        <VotationTimer />
        <Candidates />
        <VoteButton />
      </FullHeightSkeleton>
    </ThemeProvider>
  )
}

export default VotationView
