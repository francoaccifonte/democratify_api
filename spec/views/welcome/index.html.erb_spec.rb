require 'rails_helper'

RSpec.describe "welcome/index" do
  it 'renders the react component' do
    allow(view).to receive(:react_component)
    render
    expect(view).to(
      have_received(:react_component)
      .with(
        'HomeHoc',
        props: hash_including(
          {
            ongoingPlaylist: anything,
            votation: anything,
            cognitoEndpoint: anything,
            backendBaseUrl: anything
          }
        ),
        prerender: false
      )
    )
  end
end
