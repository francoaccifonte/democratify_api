require 'rails_helper'

RSpec.describe "accounts/login" do
  context 'when login is succesful' do
    it 'renders the react component' do
      assign(:failed_auth, false)
      allow(view).to receive(:react_component)
      render
      expect(view).to(
        have_received(:react_component)
        .with('LoginViewHoc',
              props: { failedAuth: false },
              prerender: false)
      )
    end
  end

  context 'when login fails' do
    it 'renders the react component' do
      assign(:failed_auth, true)
      allow(view).to receive(:react_component)
      render
      expect(view).to(
        have_received(:react_component)
        .with('LoginViewHoc',
              props: { failedAuth: true },
              prerender: false)
      )
    end
  end
end
