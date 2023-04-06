# frozen_string_literal: true

class VotationTransitionWorker
  include Sidekiq::Worker
  sidekiq_options queue: :spotify_ongoing_playlist_sync

  def perform(ongoing_playlist_id) # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
    @playlist = OngoingPlaylist.find(ongoing_playlist_id)
    current_votation = @playlist.votations.in_progress.first

    # No idea why, but a spec fails without this line: rspec ./spec/workers/votation_transition_worker_spec.rb:37
    @playlist.votations.queued.first

    winner_candidate = current_votation.winner

    ActiveRecord::Base.transaction do
      # TODO: split into two separate workers so the song is enqued in spotify only once.
      #       there should also be some management to drop the playlist if one of them fails
      send_to_active_remote(winner_candidate.spotify_playlist_song)

      @playlist.update!(playing_song_id: winner_candidate.spotify_playlist_song.id)

      send_candidates_to_end_of_queue
      @playlist.votations.in_progress.first.destroy!
      # TODO: check if a scheduled votation exists and use that one.
      @playlist.votations.create!(
        in_progress: true,
        scheduled_start_for: Time.zone.now + @playlist.playing_song_remaining_time
      )
    end
  end

  def send_to_active_remote(song)
    song.send_to_active_remote
    song.update!(enqueued_at: Time.zone.now)
  end

  def send_candidates_to_end_of_queue
    index = @playlist.remaining_songs.last.index
    @playlist.voting_songs.each do |song|
      song.update!(index: (song.index || 0) + index)
    end
  end
end
