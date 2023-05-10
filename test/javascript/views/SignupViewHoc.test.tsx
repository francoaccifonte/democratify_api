import React from 'react';
import { render } from '@testing-library/react';
import '@testing-library/jest-dom'


import { SignupViewHoc } from '../../../app/javascript/components/views';

describe('Message component', () => {
  it('renders the message prop', () => {
    const { getByText } = render(<SignupViewHoc />);
    expect(getByText('USUARIO')).toBeInTheDocument();
  });
});
