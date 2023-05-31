module ApplicationHelper
  include SerializationConcern

  def serialized_account(account, options: {})
    options[:except].nil? ? options[:except] = %i[token] : options[:except] << :token

    AccountSerializer.new(**options).serialize_to_json(account)
  end

  def hoc_params
    {
      ongoingPlaylist: serialize_one(@ongoing_playlist),
      votation: serialize_one(@votation)
    }
  end
end
