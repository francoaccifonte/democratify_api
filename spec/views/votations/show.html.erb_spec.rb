require 'rails_helper'

RSpec.describe "votations/show" do
  let!(:account) { create(:account) }
  let!(:spotify_playlist) { create(:spotify_playlist, :with_songs, account:) }
  let!(:ongoing_playlist) { create(:ongoing_playlist, :with_votation, account:, spotify_playlist:) }
  let!(:votation) { ongoing_playlist.votations.in_progress.first }

  before do
    assign(:votation, votation)
  end

  it 'renders the react component' do
    allow(view).to receive(:react_component)
    render
    expect(view).to(
      have_received(:react_component)
      .with('VotationViewHoc',
            props: hash_including(
              {
                votation: VotationSerializer.new.serialize_to_json(votation)
              }
            ),
            prerender: false)
    )
  end
end
