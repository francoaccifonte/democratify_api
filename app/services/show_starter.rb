class ShowStarter
  def initialize(account:, spotify_playlist:)
    @account = account
    @playlist = spotify_playlist
  end

  def self.call(*args, **kwargs)
    new(*args, **kwargs).call
  end

  def call
    raise 'Account does not have a spotify_user' if account.spotify_user.blank?

    ActiveRecord::Base.transaction do
      account.ongoing_playlist&.destroy!
      ongoing_playlist = OngoingPlaylist.create!(account:, spotify_playlist: playlist)

      send_to_active_remote(ongoing_playlist)
      create_votation(ongoing_playlist)
    end
  end

  def client
    @client ||= Spotify::Client.from_user(@account.spotify_user)
  end

  private

  attr_reader :account, :playlist

  def send_to_active_remote(ongoing_playlist)
    client.add_to_active_playback_queue!(ongoing_playlist.playing_song.uri)
    ongoing_playlist.playing_song.update!(enqueued_at: Time.zone.now)
  end

  def create_votation(ongoing_playlist)
    ongoing_playlist.votations.create!(
      in_progress: true,
      scheduled_start_for: Time.zone.now + client.playing_song_remaining_time.seconds
    )
  end
end
