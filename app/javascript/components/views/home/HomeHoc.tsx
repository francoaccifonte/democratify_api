import React from 'react'

import { Home } from '.'
import Hoc, { HocPropsType } from '../../common/Hoc'

type HomeHocProps = HocPropsType

const HomeHoc: React.FC<HomeHocProps> = (props): JSX.Element => {
  return (
    <Hoc {...props}>
      <Home />
    </Hoc>
  )
}

export default HomeHoc
