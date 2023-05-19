# == Schema Information
#
# Table name: spotify_songs
#
#  id          :bigint           not null, primary key
#  album       :string
#  artist      :string           not null
#  cover_art   :jsonb
#  duration    :float
#  genre       :string
#  metadata    :jsonb
#  title       :string           not null
#  uri         :string           not null
#  year        :bigint
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  external_id :string           not null
#
# Indexes
#
#  index_spotify_songs_on_album        (album)
#  index_spotify_songs_on_artist       (artist)
#  index_spotify_songs_on_external_id  (external_id)
#  index_spotify_songs_on_title        (title)
#
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
