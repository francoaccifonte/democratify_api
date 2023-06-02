/* eslint-disable camelcase */
import { faker } from '@faker-js/faker'
import { serializedAccount } from '../../../app/javascript/components/types'

type SerializedAccountFactoryParams = Partial<serializedAccount>;

export const SerializedAccountFactory = (params: SerializedAccountFactoryParams = {}): serializedAccount => {
  const fakedParams: serializedAccount = {
    id: params.id || faker.number.int({ min: 10000000 }),
    email: params.email || faker.internet.email(),
    name: params.name || faker.company.name(),
    token: params.token || faker.string.uuid(),
    created_at: params.created_at || new Date(),
    updated_at: params.updated_at || new Date(),
  }

  return { ...fakedParams }
}
