require 'rails_helper'

describe VotationSerializer do
  subject { described_class.new().serialize_to_json(votation) }

  let!(:spotify_playlist) { create(:spotify_playlist, :with_songs) }
  let!(:ongoing_playlist) { create(:ongoing_playlist, :with_votation, spotify_playlist:) }
  let(:votation) { ongoing_playlist.votations.in_progress.first }

  it 'contains the correct attributes' do
    %i[id in_progress queued scheduled_close_for scheduled_end_at scheduled_end_for scheduled_start_at scheduled_start_for started_at created_at updated_at
       account_id ongoing_playlist_id].each do |attribute|
         expect(subject).to include("\"#{attribute}\":")
         expect(subject).to include(votation.attributes[attribute].to_s) # if votation.attributes[attribute]
       end
  end
end
