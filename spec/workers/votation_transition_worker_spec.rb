require 'rails_helper'

RSpec.describe VotationTransitionWorker, type: :worker do
  include_context 'with mocked spotify client'

  context 'when ending a votation' do
    subject { VotationTransitionWorker.new.perform(ongoing_playlist.id) }

    let!(:mock) { mocked_client }
    let!(:account) { create(:account) }
    let!(:user) { create(:spotify_user, account:) }
    let!(:songs) { create_list(:spotify_playlist_song, 10, spotify_playlist: playlist) }
    let!(:playlist) { create(:spotify_playlist, account:, spotify_user: user) }
    let!(:ongoing_playlist) do
      create(:ongoing_playlist,
             account:,
             spotify_playlist: playlist)
    end
    let!(:candidates_before_tally) { ongoing_playlist.votations.first.spotify_playlist_songs }

    before { mock_user(mock) }

    context 'when there is a winner,' do
      before do
        ongoing_playlist.votations.first.votation_candidates.each_with_index do |candidate, index|
          candidate.update!(votes: (index + 2)**2)
        end
      end

      let(:winner) { ongoing_playlist.votations.first.votation_candidates.max_by(&:votes) }

      xit 'sends the winner to the active remote' do
        expect(mock).to receive(:add_to_active_playback_queue).with(winner.spotify_song.uri)
        subject
      end

      it 'updates the ongoing playlist with the winner' do
        expect { subject }.to change { ongoing_playlist.reload.playing_song_id }.to(winner.spotify_playlist_song.id)
      end

      it 'creates a new votation' do
        expect { subject }.to(change { ongoing_playlist.votations.first.id })
      end

      it 'sends the losers to the end of the queue' do
        indexes = candidates_before_tally.map(&:index)
        subject
        new_indexes = candidates_before_tally.map { |cd| cd.reload.index }
        expect(new_indexes.max).to be >= (indexes.max + ongoing_playlist.spotify_songs.count - 1)
      end

      it 'deletes the old votation' do
        expect { subject }.not_to(change { Votation.count })
      end
    end
  end
end
