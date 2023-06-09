import React from 'react'

import Hoc, { HocPropsType } from '../../common/Hoc'
import { VotationView } from './'
import { userPalette } from '../../ColorPalette'

type VotationViewHocProps = {
  accountId: string
} & HocPropsType

const VotationViewHoc: React.FC<VotationViewHocProps> = (props): JSX.Element => {
  return (
    <Hoc {...{ palette: userPalette, ...props }} >
      <VotationView accountId={Number(props.accountId)}/>
    </Hoc>
  )
}

export default VotationViewHoc
