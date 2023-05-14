require "rails_helper"

RSpec.describe SpotifyPlaylistsController do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/accounts/login").to route_to("accounts#login")
    end

    it "routes to #show" do
      expect(get: "/accounts/signup").to route_to("accounts#signup")
    end

    it 'routes to #login_form' do
      expect(post: '/accounts/login').to route_to('accounts#login_form')
    end

    it 'routes to #signup' do
      expect(post: 'accounts/signup').to route_to('api/accounts#signup')
    end
  end
end
