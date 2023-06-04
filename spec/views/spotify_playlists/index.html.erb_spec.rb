require 'rails_helper'

RSpec.describe "spotify_playlists/index" do
  let!(:account) { create(:account) }
  let!(:spotify_playlists) { create_list(:spotify_playlist, 2) }

  before do
    assign(:account, account)
    assign(:spotify_playlists, spotify_playlists)
  end

  it 'renders the react component' do
    allow(view).to receive(:react_component)
    render
    expect(view).to(
      have_received(:react_component)
      .with('SpotifyPlaylistSelectionViewHoc',
            props: hash_including(
              {
                account: serialized_account(account),
                playlists: serialize_many(spotify_playlists, options: { except: %i[spotify_songs sample_songs] })
              }
            ),
            prerender: false)
    )
  end
end
