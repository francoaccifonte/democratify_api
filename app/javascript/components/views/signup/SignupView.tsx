import React from 'react'

import { FullHeightSkeleton } from '../../common/'
import { SignupCard, SignupSuccessCard } from '.'

const SignupView = () => {

  const Content = () => {
    // switch (signUpState) {
    //   case 'idle':
    //   case 'pending':
    //     return <SignupCard />
    //   case 'fulfilled':
    //     return <SignupSuccessCard />
    //   case 'rejected':
    //     return <></>
    //     // TODO: Show error message
    //   default:
    //     return <></>
    // }
    return <SignupCard />
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

const styles = (theme: any) => {
  return {
    farafa: {
      backgroundColor: theme.Primary
    }
  }
}

export default SignupView
