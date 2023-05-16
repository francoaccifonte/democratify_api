import { faker } from '@faker-js/faker';
import { serializedAccount } from "../../../app/javascript/components/types";

export const serialized_account_fixture = (): serializedAccount => {
  return {
    id: faker.number.int({ min: 10000000 }),
    email: faker.internet.email(),
    name: faker.company.name(),
    token: faker.string.uuid(),
    created_at: new Date(),
    updated_at: new Date(),
  }
}
