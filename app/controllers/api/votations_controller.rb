# frozen_string_literal: true

module Api
  class VotationsController < Api::ApiController
    before_action :set_votation, only: %i[show vote]

    def show
      render_one @votation
    end

    def update
      nil
    end

    def vote
      @votation.votation_candidates.find(params.require(:candidate_id)).vote!

      render_one @votation
    end

    private

    def set_votation
      @votation = Account.find(params.require(:account_id)).votations.in_progress.first
    end
  end
end
