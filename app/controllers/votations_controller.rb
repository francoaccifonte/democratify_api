class VotationsController < ApplicationController
  before_action :set_votation, only: %i[show]

  # GET /votations/1
  def show; end

  private

  def set_votation
    @votation = Account.find(params.require(:account_id)).votations.in_progress.first
  end
end
