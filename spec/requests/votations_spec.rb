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
end
