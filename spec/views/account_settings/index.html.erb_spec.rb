require 'rails_helper'

RSpec.describe "account_settings/index" do
  let!(:account) { create(:account) }

  it 'renders the react component' do
    allow(view).to receive(:react_component).and_call_original
    assign(:account, account)
    render
    expect(view).to have_received(:react_component).with('AccountConfigViewHoc',
                                                         props: { account: anything, spotifyAuthUri: anything },
                                                         prerender: false)
  end
end
