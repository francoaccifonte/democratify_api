import { AccountModel } from './account_model'

class Client {
  token: string | undefined;
  account: AccountModel;

  constructor (token?: string) {
    this.token = token
    this.account = new AccountModel(token)
  }

  reloadModels (token?: string) {
    this.account = new AccountModel(token)
  }

  setToken (token: string) {
    this.token = token
    this.reloadModels(token)
  }

  reset () {
    this.token = undefined;
    this.reloadModels(this.token)
  }
}

export { Client }
