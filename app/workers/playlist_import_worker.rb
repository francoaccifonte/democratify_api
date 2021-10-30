class PlaylistImportWorker
  def perform(integration_id)
    integration = Integration.find(integration_id)

    token = integration&.active_token&.token || integration.token

    Spoitfy::Client.new(token).playlists[:items].pluck(:id).each do |playlist_id|
      Playlist.create(
        integration: integration.front_end_token,
        external_id: playlist_id,
      )
    end
  end
end
