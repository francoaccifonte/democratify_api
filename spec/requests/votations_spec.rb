require 'rails_helper'

RSpec.describe "/votations" do
  let!(:account) { create(:account) }
  let!(:spotify_playlist) { create(:spotify_playlist, :with_songs, account:) }
  let!(:ongoing_playlist) { create(:ongoing_playlist, :with_votation, account:, spotify_playlist:) }
  let!(:votation) { ongoing_playlist.votations.in_progress.first }
  let!(:chosen_candidate) { votation.votation_candidates.first }

  before { WithAccountCookies.set_account_cookie(cookies, account) }

  describe "GET account/:id/show" do
    subject { get account_votation_url(account.id) }

    it "renders a successful response" do
      subject
      expect(response).to have_http_status(:success)
    end
  end

  describe "PUT account/:id/vote" do
    subject { put account_votation_url(account.id), params: { account_id: account.id, candidate_id: chosen_candidate.id } }

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
