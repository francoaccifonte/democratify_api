import React from 'react'

import Hoc, { HocPropsType } from '../../common/Hoc'
import { VotationView } from './'
import { userPalette } from '../../ColorPalette'

type VotationViewHocProps = {} & HocPropsType

const VotationViewHoc: React.FC<VotationViewHocProps> = (props): JSX.Element => {
  return (
    <Hoc {...{ palette: userPalette, ...props }} >
      <VotationView/>
    </Hoc>
  )
}

export default VotationViewHoc
