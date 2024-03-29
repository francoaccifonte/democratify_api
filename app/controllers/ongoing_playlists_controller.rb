class OngoingPlaylistsController < ApplicationController
  # GET /ongoing_playlists
  def index
    @ongoing_playlist = @account.ongoing_playlist
    return redirect_to spotify_playlists_url if @ongoing_playlist.nil?

    @votation = @ongoing_playlist.votations.where(in_progress: true).first
  end
end
