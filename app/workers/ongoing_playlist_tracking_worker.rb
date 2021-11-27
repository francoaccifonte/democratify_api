# frozen_string_literal: true

class OngoingPlaylistTrackingWorker
  include Sidekiq::Worker
  sidekiq_options queue: :spotify_ongoing_playlist_sync

  def perform(playlist_id)
    playlist = OngoingPlaylist.find(playlist_id)
    playlist.account.spotify_users.first.sync_devices

    playlist.playing_song.send_to_active_remote
    playlist.playing_song.update!(enqueued_at: Time.zone.now)

    playlist.votation.create!
  end
end
