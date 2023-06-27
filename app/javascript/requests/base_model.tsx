import Cookies from 'js-cookie'

export default abstract class BaseModel {
  baseUrl: string
  token: string | undefined

  constructor (token?: string) {
    // this.baseUrl = 'http://localhost:3001'
    this.baseUrl = window.location.hostname
    this.token = token
  }

  url (): string {
    return (`${this.baseUrl}/${this.modelName()}`)
  }

  modelName (): string {
    throw new Error('Model name not specified')
  }

  baseHeaders (): object {
    let headers: object = {
      'Content-Type': 'application/json',
      Accept: 'application/json'
    }
    const token = this.token || Cookies.get('token')
    if (token) {
      headers = { ...headers, Authorization: `Bearer ${token}` }
    }
    return headers
  }

  show (id: number) {
    return this.get(`/${id}`)
  }

  list (params?: any) {
    return this.get('', params)
  }

  put (id: number, body: object = {}, path: string = '') {
    let options: object = {
      method: 'PUT',
      mode: 'cors',
      body: JSON.stringify(body)
    }
    options = { ...options, headers: this.baseHeaders() }
    return fetch(
      `${this.url()}${path}/${id}`,
      options
    )
  }

  post (body: object = {}, path: string = '') {
    let options: object = {
      method: 'POST',
      mode: 'cors',
      body: JSON.stringify(body)
    }
    options = { ...options, headers: this.baseHeaders() }
    return fetch(
      `${this.url()}${path}`,
      options
    )
  }

  // TODO: params type should be object
  get (path?: string, params?: any) {
    const url = new URL(`${this.url()}${path}`)
    if (params) {
      for (const key in params) {
        url.searchParams.append(key, params[key])
      }
    }

    let options: object = {
      method: 'GET',
      mode: 'cors'
    }
    options = { ...options, headers: this.baseHeaders() }
    return fetch(
      url.toString(),
      options
    )
  }

  // The following methods trigger requests against arbitrary urls
  appGet (path?: string, params?: any) {
    const url = new URL(`${this.baseUrl}/${path}`)
    if (params) {
      for (const key in params) {
        url.searchParams.append(key, params[key])
      }
    }

    let options: object = {
      method: 'GET',
      mode: 'cors'
    }
    options = { ...options, headers: this.baseHeaders() }
    return fetch(
      url.toString(),
      options
    )
  }

  appPut (body?: any, path: string = '') {
    let options: object = {
      method: 'PUT',
      mode: 'cors',
      body: JSON.stringify(body)
    }
    options = { ...options, headers: this.baseHeaders() }
    return fetch(
      `${this.baseUrl}/${path}`,
      options
    )
  }

  appPost (body?: any, path: string = '') {
    let options: object = {
      method: 'POST',
      mode: 'cors',
      body: JSON.stringify(body)
    }
    options = { ...options, headers: this.baseHeaders() }
    return fetch(
      `${this.baseUrl}/${path}`,
      options
    )
  }
}
