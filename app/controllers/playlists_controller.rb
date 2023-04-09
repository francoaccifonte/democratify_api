class PlaylistsController < ApiController
  def index
    @playlists = Playlist.where(account_id: params.require(:account_id))
  end

  def show
    render_one(Playlist.includes(:songs).find(params.require(:id)))
  end

  def create
    new_playlist = Playlist.create!(playlist_params)
    render json: new_playlist, status: :created
  end
end
