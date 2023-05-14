require 'rails_helper'

describe SpotifySongSerializer do
  subject { described_class.new(**options).serialize_to_json(spotify_song) }

  let(:spotify_song) { create(:spotify_song) }
  let(:options) { {} }

  it 'contains the correct attributes' do
    %i[id album artist cover_art duration genre metadata title uri year created_at updated_at external_id].each do |attribute|
      expect(subject).to include("\"#{attribute}\":")
      expect(subject).to include(spotify_song.attributes[attribute].to_s) if spotify_song.attributes[attribute]
    end
  end
end
