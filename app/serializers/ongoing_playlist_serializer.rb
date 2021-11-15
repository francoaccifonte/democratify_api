class OngoingPlaylistSerializer < Panko::Serializer
  attributes :id, :created_at, :updated_at

  has_one :account, serializer: AccountSerializer
  has_one :spotify_playlist, serializer: SpotifyPlaylistSerializer
end
