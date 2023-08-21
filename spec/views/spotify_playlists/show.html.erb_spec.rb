require 'rails_helper'

RSpec.describe "spotify_playlists/show" do
  let(:props) { { hash: 123 } }

  before do
    assign(:component_props, props)
  end

  it 'renders the react component' do
    allow(view).to receive(:react_component)
    render
    expect(view).to(
      have_received(:react_component)
      .with('SpotifyPlaylistShowViewHoc',
            props: hash_including(props),
            prerender: false)
    )
  end
end
