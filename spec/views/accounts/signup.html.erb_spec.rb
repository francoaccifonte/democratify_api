require 'rails_helper'

RSpec.describe "accounts/signup" do
  it 'renders the react component' do
    assign(:failed_auth, false)
    allow(view).to receive(:react_component)
    render
    expect(view).to(
      have_received(:react_component)
      .with('SignupViewHoc',
            prerender: false)
    )
  end
end
