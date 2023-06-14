# frozen_string_literal: true

class VotationTransitionWorker
  include Sidekiq::Worker
  sidekiq_options queue: :spotify_ongoing_playlist_sync

  def perform(ongoing_playlist_id) # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
    @playlist = OngoingPlaylist.find(ongoing_playlist_id)
    current_votation = @playlist.votations.in_progress.first
    winner_candidate = current_votation.winner
    @initial_song_set_ids = {
      playing_song: @playlist.playing_song_id,
      voting_songs: @playlist.voting_songs.pluck(:id),
      remaining_songs: @playlist.remaining_songs.pluck(:id)
    }

    ActiveRecord::Base.transaction do
      send_to_active_remote(winner_candidate.spotify_playlist_song.uri)

      send_candidates_to_end_of_queue
      @playlist.update!(playing_song_id: winner_candidate.spotify_playlist_song.id)
      winner_candidate.spotify_playlist_song.update!(enqueued_at: Time.zone.now)

      current_votation.destroy!
      votation = @playlist.votations.new(
        in_progress: true,
        scheduled_start_for: Time.zone.now + client.playing_song_remaining_time
      )
      @playlist.pool_size.times do |i|
        votation.votation_candidates << VotationCandidate.new(
          spotify_playlist_song_id: @initial_song_set_ids.fetch(:remaining_songs)[i],
          account: @playlist.account,
          ongoing_playlist: @playlist
        )
      end

      votation.save!
    end
  end

  def client
    @client ||= Spotify::Client.from_user(SpotifyUser.find_by(account_id: @playlist.account_id))
  end

  def send_to_active_remote(song_uri)
    client.add_to_active_playback_queue!(song_uri)
  end

  def send_candidates_to_end_of_queue
    PlaylistReorderer.call(
      spotify_playlist: @playlist.spotify_playlist,
      new_order: [
        *@initial_song_set_ids.fetch(:remaining_songs),
        *@initial_song_set_ids.fetch(:voting_songs),
        @initial_song_set_ids.fetch(:playing_song)
      ]
    )
  end
end
