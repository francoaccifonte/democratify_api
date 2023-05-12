import { serialized_account } from "../../../app/javascript/components/types";

export const serialized_account_fixture = (): serialized_account => {
  return {
    id: 123,
    email: 'fafa@fefe.com',
    name: 'farafa',
    token: 'kjjjjnienpedotelodigo',
    created_at: new Date(),
    updated_at: new Date(),
  }
}
