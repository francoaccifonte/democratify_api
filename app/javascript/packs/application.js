import ReactOnRails from 'react-on-rails';

import { AccountConfigViewHoc, HomeHoc, SignupHoc, LoginViewHoc } from '../components/views';
import { library } from '@fortawesome/fontawesome-svg-core'
import { fas } from '@fortawesome/free-solid-svg-icons'
import { fab } from '@fortawesome/free-brands-svg-icons'

library.add(fas, fab)

ReactOnRails.register({
  AccountConfigViewHoc,
  HomeHoc,
  SignupHoc,
  LoginViewHoc
});
