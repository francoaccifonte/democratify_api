# frozen_string_literal: true

class ImportSpotifySongsIntoPlaylistWorker
  include Sidekiq::Worker

  def self.queue
    :spotify_import
  end

  def self.jobs_for_user?(user_id)
    return unless user_id

    queue = Sidekiq::Queue.new(self.queue)
    queue.detect { |job| job.args.second == user_id }.present?
  end

  sidekiq_options queue: :spotify_import

  # TODO: remove songs if they were removed from the spotfify playlist (from the api response)
  def perform(playlist_id, spotify_user_id) # rubocop:disable Metrics/AbcSize
    playlist = SpotifyPlaylist.find(playlist_id)
    client = SpotifyUser.find(spotify_user_id).client

    songs = client.playlist_tracks(playlist.external_id).fetch(:items)
    initial_index = playlist.spotify_playlist_songs.count

    songs.each_with_index do |song, index|
      spotify_song = find_or_create_song(song.fetch(:track))
      sps = playlist.spotify_playlist_songs.find_or_initialize_by(spotify_song:)
      sps.assign_attributes(index: index + initial_index)
      sps.save!
    end
  end

  def find_or_create_song(song)
    new_song = SpotifySong.find_or_initialize_by(external_id: song.fetch(:id))
    new_song.assign_attributes(
      uri: song.fetch(:uri),
      title: song.fetch(:name),
      artist: song.fetch(:artists).pluck(:name).join(' - '),
      album: song.fetch(:album).fetch(:name),
      cover_art: song.fetch(:album).fetch(:images),
      duration: song.fetch(:duration_ms)
    )
    new_song.save!
    new_song
  end
end
