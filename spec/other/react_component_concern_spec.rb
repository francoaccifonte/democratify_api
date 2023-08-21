require 'rails_helper'
# rubocop:disable RSpec/FilePath

# I'm testing this concern through the SpotifyPlaylistsController because it's a lot of boilerplate
# to create a dummy controller just to test it

describe SpotifyPlaylistsController, type: :request do
  let(:account) { create(:account) }
  let!(:spotify_playlists) { create(:spotify_playlist, account:) }

  before { WithAccountCookies.set_account_cookie(cookies, account) }

  context 'when a request renders a react component' do
    it 'adds the props for that action' do
      get '/spotify_playlists'
      expect(controller.instance_variable_get(:@component_props)).to include(
        account: AccountSerializer.new.serialize_to_json(account),
        playlists: anything
      )
    end

    it 'adds the default props' do
      get '/spotify_playlists'
      expect(controller.instance_variable_get(:@component_props)).to include(
        {
          ongoingPlaylist: anything,
          votation: anything
        }
      )
    end
  end
end

# rubocop:enable RSpec/FilePath
