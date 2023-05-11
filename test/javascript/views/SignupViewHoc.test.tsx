import React from 'react';
import { act, render, fireEvent, getByText } from '@testing-library/react';
import '@testing-library/jest-dom'
import client, { AccountModel } from '../../../app/javascript/requests/';

import { SignupViewHoc } from '../../../app/javascript/components/views';


beforeEach(() => client.reset());

describe('SignupViewHoc', () => {
  it('has the correct fields and sends the request with correct params', async () => {
    const mockedInstance = {
      signUp: jest.fn()
    };
    mockedInstance.signUp.mockReturnValue({
      status: 200,
      json: new Promise((resolve, reject) => resolve({ id: 1 }))
    })
    client.account = mockedInstance as unknown as AccountModel;

    const subject = render(<SignupViewHoc />);

    expect(subject.getByText('USUARIO')).toBeInTheDocument();
    
    act(() => {
      fireEvent.change(subject.getByLabelText('USUARIO'), { target: { value: 'testUser' } })
      fireEvent.change(subject.getByLabelText('CONTRASEÑA'), { target: { value: 'testPassword' } })
      fireEvent.change(subject.getByLabelText('CONFIRMAR CONTRASEÑA'), { target: { value: 'testPassword' } })
      fireEvent.change(subject.getByLabelText('CORREO ELECTRÓNICO'), { target: { value: 'test@example.com' } })
    })

    expect(subject.getByLabelText('USUARIO')).toHaveValue('testUser')
    expect(subject.getByLabelText('CONTRASEÑA')).toHaveValue('testPassword')
    expect(subject.getByLabelText('CONFIRMAR CONTRASEÑA')).toHaveValue('testPassword')
    expect(subject.getByLabelText('CORREO ELECTRÓNICO')).toHaveValue('test@example.com')

    await act( async () => fireEvent.click(subject.getByText('Enviar')));

    expect(mockedInstance.signUp).toHaveBeenCalledWith('test@example.com', 'testPassword', 'testUser');
    expect(subject.getByText('¡Listo! Ya podes loguearte con tu cuenta.')).toBeInTheDocument
  });

  it('shows an error message when request fails', async () => {
    const mockedInstance = {
      signUp: jest.fn()
    };
    mockedInstance.signUp.mockReturnValue({
      status: 422,
      json: new Promise((resolve, reject) => resolve({ body: 'SomeErrorMessage' }))
    })
    client.account = mockedInstance as unknown as AccountModel;

    const subject = render(<SignupViewHoc />);

    fireEvent.change(subject.getByLabelText('USUARIO'), { target: { value: 'testUser' } })
    fireEvent.change(subject.getByLabelText('CONTRASEÑA'), { target: { value: 'testPassword' } })
    fireEvent.change(subject.getByLabelText('CONFIRMAR CONTRASEÑA'), { target: { value: 'testPassword' } })
    fireEvent.change(subject.getByLabelText('CORREO ELECTRÓNICO'), { target: { value: 'test@example.com' } })

    await act( async () => fireEvent.click(subject.getByText('Enviar')));

    expect(subject.getByText('Ups, algo salio mal')).toBeInTheDocument
  })
});
