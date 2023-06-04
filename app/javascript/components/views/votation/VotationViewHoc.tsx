import React, { useContext } from 'react'

import Hoc, { HocPropsType } from '../../common/Hoc'
import { VotationView } from './'
import { FooterContext } from '../contexts/FooterContext'

type VotationViewHocProps = {} & HocPropsType

const VotationViewHoc: React.FC<VotationViewHocProps> = (props): JSX.Element => {
  const { votation } = useContext(FooterContext)
  return (
    <Hoc {...props} >
      <VotationView votation={votation}/>
    </Hoc>
  )
}

export default VotationViewHoc
