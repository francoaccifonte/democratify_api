import React, { useContext, useState, ChangeEvent } from 'react'
import Button from 'react-bootstrap/Button'
import moment from 'moment'
import withStyles, { ThemeProvider } from 'react-jss'
import { ClientJS } from 'clientjs'

import client from '../../../requests/'
import { Text, FullHeightSkeleton } from '../../common'
import { userPalette } from '../../ColorPalette'
import { Candidate } from '.'
import { FooterContext } from '../contexts/FooterContext'
import { serializedVotationCandidate } from '../../types'

type VotationViewParams = {
  classes: any;
  accountId: number;
};

const VotationView: React.FC<VotationViewParams> = (props): JSX.Element => {
  const [selected, setSelected] = useState<serializedVotationCandidate | undefined>(undefined)
  const { votation } = useContext(FooterContext)
  const [previousVotationIds, setPreviousVotationIds] = useState<String[]>(localStorage.getItem('votation_ids')?.split(',') || [])
  const { accountId } = props

  const voteAlreadyCasted = previousVotationIds.includes(String(votation.id))

  const handleVote = async (event: React.MouseEvent<HTMLButtonElement>) => {
    const response = await client.votations.castVote(accountId, selected.id, new ClientJS().getFingerprint())
    if (response.ok) {
      const newVotationList = [...previousVotationIds, String(votation.id)]
      localStorage.setItem('votation_ids', newVotationList.join(','))
      setPreviousVotationIds(newVotationList)
    }
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
              <Button className={selected ? props.classes.enabledButton : props.classes.disabledButton} disabled={voteAlreadyCasted} onClick={handleVote}>Votar</Button>
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
      overflowY: 'scroll',
      paddingTop: '20px'
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
      position: 'sticky',
      bottom: 0,
      composes: 'py-4'
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

export default withStyles(styles)(VotationView)
