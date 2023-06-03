require 'rails_helper'

RSpec.describe "ongoing_playlists/index" do
  let!(:account) { create(:account) }
  let!(:spotify_playlist) { create(:spotify_playlist, :with_songs) }
  let!(:ongoing_playlist) { create(:ongoing_playlist, :with_votation, account:, spotify_playlist:) }

  before do
    assign(:account, account)
    assign(:ongoing_playlist, ongoing_playlist)
    assign(:votation, ongoing_playlist.votations.in_progress.first)
  end

  it 'renders a list of ongoing_playlists' do
    allow(view).to receive(:react_component)
    render
    expect(view).to(
      have_received(:react_component)
      .with('OngoingPlaylistViewHoc',
            props: hash_including(
              {
                account: serialized_account(account),
                ongoingPlaylist: serialize_one(ongoing_playlist),
                votation: serialize_one(ongoing_playlist.votations.in_progress.first)
              }
            ),
            prerender: false)
    )
  end
end
