require 'rails_helper'

describe OngoingPlaylistSerializer do
  subject { described_class.new.serialize_to_json(ongoing_playlist) }

  let!(:account) { create(:account) }
  let!(:spotify_playlist) { create(:spotify_playlist, :with_songs, account:) }
  let!(:ongoing_playlist) { create(:ongoing_playlist, :with_votation, spotify_playlist:, account:) }

  it 'contains the correct attributes' do
    %i[id pool_size created_at updated_at].each do |attribute|
      expect(subject).to include("\"#{attribute}\":")
      expect(subject).to include(ongoing_playlist.attributes[attribute].to_s)
    end
  end
end
