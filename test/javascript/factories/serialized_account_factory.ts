import { faker } from '@faker-js/faker';
import { serialized_account } from "../../../app/javascript/components/types";

export const serialized_account_fixture = (): serialized_account => {
  return {
    id: faker.number.int({ min: 10000000 }),
    email: faker.internet.email(),
    name: faker.company.name(),
    token: faker.string.uuid(),
    created_at: new Date(),
    updated_at: new Date(),
  }
}
