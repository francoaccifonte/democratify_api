import BaseModel from '../../../app/javascript/requests/base_model'

class Dummy extends BaseModel {
  modelName (): string {
    return ('dummy')
  }
}

describe('BaseModel', () => {
  it('has the correct base url', () => {
    const instance = new Dummy()

    expect(instance.baseUrl).toEqual('https://rockolify.holasoyfranco.com')
  })
})
