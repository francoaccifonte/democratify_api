import React, { useState } from 'react'

import { FullHeightSkeleton } from '../../common/'
import { SignupCard, SignupSuccessCard } from '.'

const SignupView = () => {
  const [signupStatus, setSignupStatus] = useState('pending')

  const Content = () => {
    switch (signupStatus) {
      case 'idle':
      case 'pending':
        return <SignupCard successfulSignupCallback={() => setSignupStatus('fulfilled')} />
      case 'fulfilled':
        return <SignupSuccessCard />
      case 'rejected':
        return <></>
        // TODO: Show error message
      default:
        return <></>
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

const styles = (theme: any) => {
  return {
    farafa: {
      backgroundColor: theme.Primary
    }
  }
}

export default SignupView
