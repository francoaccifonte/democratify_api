class VotationsController < ApplicationController
  before_action :set_votation, only: %i[show vote]

  # GET /votations/1
  def show; end

  # PUT /votations/1
  def vote
    @votation.votation_candidates.find(params.require(:candidate_id)).vote!

    render :show
  end

  private

  def set_votation
    @votation = Account.find(params.require(:account_id)).votations.in_progress.first
  end
end
