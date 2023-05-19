import { AccountModel, OngoingPlaylistModel } from './'
import Cookies from 'js-cookie'

class Client {
  token: string | undefined
  account: AccountModel
  ongoingPlaylist: OngoingPlaylistModel

  constructor (token?: string) {
    this.token = token || Cookies.get('token')
    this.account = new AccountModel(this.token)
    this.ongoingPlaylist = new OngoingPlaylistModel(this.token)
  }

  reloadModels (token?: string) {
    this.account = new AccountModel(token)
    this.ongoingPlaylist = new OngoingPlaylistModel(token)
  }

  setToken (token: string) {
    this.token = token
    this.reloadModels(token)
  }

  reset () {
    this.token = undefined
    this.reloadModels(this.token)
  }
}

export { Client }
