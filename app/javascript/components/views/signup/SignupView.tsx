import React, { useState } from 'react'

import { FullHeightSkeleton } from '../../common/'
import { SignupCard, SignupSuccessCard } from '.'

type SignupViewProps = {
  signupSuccessful?: Boolean
}

const SignupView = (props: SignupViewProps) => {

  const Content = () => {
    if (props.signupSuccessful !== undefined) {
      if (props.signupSuccessful) {
        return <SignupSuccessCard />
      } else {
        return <></> // TODO: Show some error
      }
    } else {
      return <SignupCard />
    }
  }
  return (
    <FullHeightSkeleton header palette='admin' overflowY="hidden">
      <div className="mt-5 d-flex flex-row justify-content-center w-100">
        <div >
          <Content />
        </div>
      </div>
    </FullHeightSkeleton>
  )
}

export default SignupView
