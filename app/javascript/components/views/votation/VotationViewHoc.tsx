import React from 'react'

import Hoc, { HocPropsType } from '../../common/Hoc'
import { VotationView } from './'

type VotationViewHocProps = {} & HocPropsType

const VotationViewHoc: React.FC<VotationViewHocProps> = (props): JSX.Element => {
  return (
    <Hoc {...props} >
      <VotationView/>
    </Hoc>
  )
}

export default VotationViewHoc
