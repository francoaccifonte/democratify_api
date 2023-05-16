module ApplicationHelper
  include SerializationConcern

  def serialized_account(account, options: {})
    options[:except].nil? ? options[:except] = %i[token] : options[:except] << :token

    AccountSerializer.new(**options).serialize_to_json(account)
  end
end
