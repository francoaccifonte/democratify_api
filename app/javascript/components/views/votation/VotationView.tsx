import React, { useContext, useState, FormEvent, ChangeEvent } from 'react'
import Button from 'react-bootstrap/Button'
import moment from 'moment'
import withStyles, { ThemeProvider } from 'react-jss'

import { Text, FullHeightSkeleton } from '../../common'
import { userPalette } from '../../ColorPalette'
import { Candidate } from '.'
import { FooterContext } from '../contexts/FooterContext'
import { serializedVotationCandidate } from '../../types'
import { Container } from 'react-bootstrap'

type VotationViewParams = {
  classes: any
};

const BetterVotationView: React.FC<VotationViewParams> = (props): JSX.Element => {
  const [selected, setSelected] = useState<serializedVotationCandidate | undefined>(undefined)
  const { votation } = useContext(FooterContext)
  const accountId = 4

  // https://www.npmjs.com/package/clientjs
  // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  // Implement fingerprinting from that package!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  const voteAlreadyCasted = false // previousVotationIds.includes(String(votationState.votation.id))

  const handleVote = async (id: number) => {
    await fetch('http://localhost:3001/accounts/4/votation', { method: 'put', body: JSON.stringify({ candidate_id: selected }) })
  }

  const updateSelectedCandidate = (event: ChangeEvent<HTMLInputElement>, candidate: serializedVotationCandidate) => {
    setSelected(candidate)
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
        <div className={props.classes.mainContainer}>
            <form className={props.classes.form} id="vote" action='votation' method='post'>
              {
                votation.votation_candidates?.map((candidate, index) => {
                  return (
                    <label key={`votationRadioFormLabel${index}`}>
                      <Candidate data={candidate} isSelected={selected?.id === candidate.id}/>
                      <input
                        key={`votationRadioFormInput${index}`}
                        type="radio"
                        name={`selected_candidate_id:${candidate.id}`}
                        className={props.classes.formInput}
                        onChange={(event) => updateSelectedCandidate(event, candidate)} />
                    </label>
                  )
                })
              }
              <input type="hidden" name="_method" value="PUT" />
              <input type="submit" value="Votar" disabled={!selected} className={selected ? props.classes.enabledButton : props.classes.disabledButton}></input>
            </form>
        </div>
      </FullHeightSkeleton>
    </ThemeProvider>
  )
}

const styles = (theme: typeof userPalette) => {
  return {
    mainContainer: {
      display: 'flex',
      flexDirection: 'row',
      justifyContent: 'center',
      width: '100%',
      overflowY: 'scroll'
    },
    form: {
      display: 'flex',
      flexDirection: 'column',
      gap: '1rem',
      width: '100%'
    },
    formInput: {
      display: 'none'
    },
    button: {
      fontFamily: 'Poppins',
      fontStyle: 'normal',
      fontWeight: 'normal',
      fontSize: '1.25rem',
      lineHeight: '1.125rem',
      border: '0',
      borderRadius: '0.5rem',
      height: '60px',
      position: 'sticky',
      bottom: 0
    },
    disabledButton: {
      backgroundColor: theme.Muted,
      composes: '$button'
    },
    enabledButton: {
      backgroundColor: theme.Success,
      composes: '$button'
    }
  }
}

export default withStyles(styles)(BetterVotationView)
