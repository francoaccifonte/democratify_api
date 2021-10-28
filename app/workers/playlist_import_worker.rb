class PlaylistImportWorker
  def perform(account_id, integration_id = nil)
    account = Account.includes(:integrations).find(account_id)
    integration = integration_id ? account.integrations.find(integration_id) : account.integrations.first
    token = integration.token

    client = Integrations::CLIENTS[integration.provider].new(token)

    playlists = client.playlists
    byebug
  end
end
