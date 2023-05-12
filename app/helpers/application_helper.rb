module ApplicationHelper
  def serialized_account(account, options: {})
    options[:except].nil? ? options[:except] = %i[token] : options[:except] << :token

    AccountSerializer.new(**options).serialize_to_json(account)
  end

  def serialized_spotify_playlists(playlists, options: {})
    Panko::ArraySerializer.new(
      playlists,
      **options.merge(each_serializer: SpotifyPlaylistSerializer)
    ).to_json
  end
end
