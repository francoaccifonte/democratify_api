require 'rails_helper'

RSpec.describe VotationTransitionWorker, type: :worker do
  include_context 'with mocked spotify client'

  context 'when ending a votation' do
    subject { described_class.new.perform(ongoing_playlist.id) }

    let(:device_response) { { devices: [{ id: 123, is_active: true }] } }
    let(:remaining_time_response) { { item: { duration_ms: 1234 }, progress_ms: 20 } }

    let!(:devices_stub) { stub_request(:get, "https://api.spotify.com/v1/me/player/devices").to_return(status: 200, body: JSON.unparse(device_response)) }
    let!(:add_to_queue_stub) { stub_request(:post, %r{https://api.spotify.com/v1/me/player/queue?}).to_return(status: 200, body: "uno", headers: {}) }
    let!(:remaining_time_stub) do
      stub_request(:get, 'https://api.spotify.com/v1/me/player?fields=item(device(id,is_active,name,volume_percent),shuffle_state,progress_ms,is_playing,item(duration_ms))')
        .to_return(status: 200, body: JSON.unparse(remaining_time_response), headers: {})
    end

    let!(:account) { create(:account) }
    let!(:user) { create(:spotify_user, account:) }
    let!(:spotify_playlist) { create(:spotify_playlist, :with_songs, account:, spotify_user: user) }
    let!(:ongoing_playlist) do
      ShowStarter.call(account:, spotify_playlist:)
      WebMock::RequestRegistry.instance.reset!
      OngoingPlaylist.last
    end

    context 'when there is a winner,' do
      before { Votation.last.votation_candidates.each_with_index { |vc, index| vc.update!(votes: index**2) } }

      it 'sends the winner to the queue' do
        subject
        assert_requested(devices_stub)
        assert_requested(add_to_queue_stub)
        assert_requested(remaining_time_stub)
      end

      it 'deletes the old votation and creates a new one' do
        old_votation = Votation.last
        expect { subject }.to(change { Votation.last.id })
        expect { Votation.find(old_votation.id) }.to raise_error(ActiveRecord::RecordNotFound)
      end

      it 'creates a new votation with the correct candidates' do
        expected_candidates = spotify_playlist.reload.spotify_playlist_songs
                                              .where.not(id: Votation.last.votation_candidates.pluck(:spotify_playlist_song_id))
                                              .where.not(id: ongoing_playlist.playing_song_id)
                                              .order(index: :asc)
                                              .first(ongoing_playlist.pool_size)

        subject
        votation = Votation.last
        expect(votation.votation_candidates.pluck(:spotify_playlist_song_id)).to match_array(expected_candidates.pluck(:id))
      end

      it 'sets the correct song as winner' do
        winner = ongoing_playlist.votations.in_progress.last.winner
        expect { subject }.to change { ongoing_playlist.reload.playing_song_id }.from(anything).to(winner.spotify_playlist_song_id)
      end

      it 'sends the losers to the end of the queue' do
        candidates_ids = ongoing_playlist.votations.in_progress.last.votation_candidates.map(&:spotify_playlist_song_id)
        initial_playing_song = ongoing_playlist.playing_song_id
        pool_size = ongoing_playlist.pool_size
        previous_playing_song = ongoing_playlist.playing_song_id

        subject
        songs = spotify_playlist.reload.spotify_playlist_songs.order(index: :asc)
        expect(songs.last.id).to eq(initial_playing_song)
        expect(songs[(-pool_size - 1)..].pluck(:id)).to match_array(candidates_ids + [previous_playing_song])
      end
    end
  end
end
