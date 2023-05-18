class OngoingPlaylistsController < ApplicationController
  # GET /ongoing_playlists
  def index
    @ongoing_playlist = @account.ongoing_playlist
    @votation = @ongoing_playlist.votations.where(in_progress: true).first
  end

  # POST /ongoing_playlists
  # PATCH/PUT /ongoing_playlists/1
  # DELETE /ongoing_playlists/1
end
