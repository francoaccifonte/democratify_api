require 'rails_helper'

RSpec.describe "spotify_playlists/show" do
  let!(:account) { create(:account) }
  let!(:playlist) { create(:spotify_playlist) }

  before do
    assign(:account, account)
    assign(:spotify_playlist, playlist)
  end

  it 'renders the react component' do
    allow(view).to receive(:react_component)
    render
    expect(view).to(
      have_received(:react_component)
      .with('SpotifyPlaylistShowViewHoc',
            props: {
              account: AccountSerializer.new({ except: [:token] }).serialize_to_json(account),
              playlist: SpotifyPlaylistSerializer.new.serialize_to_json(playlist)
            },
            prerender: false)
    )
  end
end
