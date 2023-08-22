class PlaylistImportWorker
  include Sidekiq::Worker

  def self.queue
    :spotify_import
  end

  def self.jobs_for_user?(user_id)
    return unless user_id

    queue = Sidekiq::Queue.new(self.queue)
    queue.detect { |job| job.args.first == user_id }.present? || ImportSpotifySongsIntoPlaylistWorker.jobs_for_user?(user_id)
  end

  sidekiq_options queue: PlaylistImportWorker.queue

  def perform(user_id)
    user = SpotifyUser.find(user_id)

    user.playlists.fetch(:items).each do |api_playlist|
      playlist = SpotifyPlaylist.find_or_initialize_by(external_id: api_playlist.fetch(:id), account_id: user.account_id)

      update_playlist!(playlist, user, api_playlist)
      ImportSpotifySongsIntoPlaylistWorker.perform_async(playlist.id, user_id)
    end
  end

  private

  def update_playlist!(playlist, user, api_playlist)
    cover_art = user.client.playlist_cover_art(api_playlist.fetch(:id)).first[:url]

    playlist.assign_attributes(
      account_id: user.account_id,
      spotify_user: user,
      external_id: api_playlist.fetch(:id),
      name: api_playlist.fetch(:name),
      description: api_playlist.fetch(:description),
      cover_art_url: cover_art,
      updated_at: Time.current
    )
    playlist.save!
  end
end
