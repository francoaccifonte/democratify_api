# frozen_string_literal: true

class InitialVotationStartWorker
  include Sidekiq::Worker
  sidekiq_options queue: :spotify_ongoing_playlist_sync

  def perform(playlist_id)
    playlist = OngoingPlaylist.find(playlist_id)

    send_to_active_remote(playlist.playing_song)
    remaining_time = playlist.playing_song_remaining_time

    playlist.votations.create!(
      in_progress: true,
      scheduled_start_for: Time.zone.now + remaining_time.seconds
    )
  end

  def send_to_active_remote(song)
    song.send_to_active_remote
    song.update!(enqueued_at: Time.zone.now)
  end
end
