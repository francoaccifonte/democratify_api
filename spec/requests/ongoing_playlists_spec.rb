require 'rails_helper'

RSpec.describe "/ongoing_playlists" do
  let!(:account) { create(:account) }
  let!(:ongoing_playlist) { create(:ongoing_playlist, account:) }

  pending 'test post put delete and index'
end
