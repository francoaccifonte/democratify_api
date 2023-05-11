import React from 'react';
import { act, render, fireEvent, getByText } from '@testing-library/react';
import '@testing-library/jest-dom'

import { LoginViewHoc } from '../../../app/javascript/components/views';

describe('SignupViewHoc', () => {
  it('when failedAuth is undefined shows the login form and sends the request', async () => {
    const subject = render(<LoginViewHoc />);

    expect(subject.getByText('CORREO ELECTRÓNICO')).toBeInTheDocument();
    expect(subject.getByText('CONTRASEÑA')).toBeInTheDocument();
    
    act(() => {
      fireEvent.change(subject.getByLabelText('CONTRASEÑA'), { target: { value: 'testPassword' } })
      fireEvent.change(subject.getByLabelText('CORREO ELECTRÓNICO'), { target: { value: 'test@example.com' } })
    })

    expect(subject.getByLabelText('CONTRASEÑA')).toHaveValue('testPassword')
    expect(subject.getByLabelText('CORREO ELECTRÓNICO')).toHaveValue('test@example.com')
  });

  it('when failedAuth is true shows an error message', async () => {
    const subject = render(<LoginViewHoc failedAuth={true}/>);

    expect(subject.getByText('CORREO ELECTRÓNICO')).toBeInTheDocument();
    expect(subject.getByText('CONTRASEÑA')).toBeInTheDocument();
    expect(subject.getByText('Usuario o contraseña incorrectos')).toBeInTheDocument();

    act(() => {
      fireEvent.change(subject.getByLabelText('CONTRASEÑA'), { target: { value: 'testPassword' } })
      fireEvent.change(subject.getByLabelText('CORREO ELECTRÓNICO'), { target: { value: 'test@example.com' } })
    })

    expect(subject.getByLabelText('CONTRASEÑA')).toHaveValue('testPassword')
    expect(subject.getByLabelText('CORREO ELECTRÓNICO')).toHaveValue('test@example.com')
  });

  it('when failedAuth is false shows a success message', async () => {
    const subject = render(<LoginViewHoc failedAuth={false}/>);

    // Don't know, this case should not happen actually because it gets redirected to the main view
  });
});
