import BaseModel from './base_model'

class VotationModel extends BaseModel {
  modelName (): string {
    return 'votations'
  }

  show (id: number, token: string = '') {
    return this.appGet(`accounts/${id}/votation`, { token })
  }

  castVote (accountId: number, candidateId: number, fingerprint: string = '') {
    return this.appPut({ candidate_id: candidateId, fingerprint }, `api/accounts/${accountId}/votation`)
  }
}

export { VotationModel }
