require 'rails_helper'

RSpec.describe "ongoing_playlists/index" do
  before do
    assign(:ongoing_playlists, [
             OngoingPlaylist.create!,
             OngoingPlaylist.create!
           ])
  end

  xit "renders a list of ongoing_playlists" do
    render
  end
end
