require 'rails_helper'

RSpec.describe Api::VotationsController do
  let!(:account) { create(:account) }
  let(:auth_headers) { { Authorization: "Bearer #{account.token}" } }
  let!(:spotify_playlist) { create(:spotify_playlist, :with_songs, account:) }
  let!(:ongoing_playlist) { create(:ongoing_playlist, :with_votation, account:, spotify_playlist:) }
  let!(:votation) { ongoing_playlist.votations.in_progress.first }
  let!(:chosen_candidate) { votation.votation_candidates.first }

  describe "PUT /api/account/:id/vote" do
    subject { put api_account_votation_url(account.id), params: { account_id: account.id, candidate_id: chosen_candidate.id }, headers: auth_headers }

    context "with valid parameters" do
      it 'casts a vote' do
        expect { subject }.to change { chosen_candidate.reload.votes }.by(1)
      end

      it 'is successful' do
        subject
        expect(response).to have_http_status(:success)
      end
    end
  end
end
