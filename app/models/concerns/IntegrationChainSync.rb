module IntegrationChainSync
  extend ActiveSupport::Concern

  included do
    before_save :set_grandparent

    after_create_commit :set_myself_in_parents
    after_create_commit :create_children

    after_destroy_commit :remove_myself_from_parents
  end

  def set_grandparent
    return unless type_in_chain == 'refresh_token'

    self.front_end_token_id = parent.parent.id
  end

  def set_myself_in_parents
    return if type_in_chain == 'front_end_token'

    parent.update!("#{type_in_chain}_id": id)
    parent&.parent&.update!("#{type_in_chain}_id": id)
  end

  def remove_myself_from_parent
    return if type_in_chain == 'front_end_token'

    parent.update!("#{type_in_chain}_id": nil)
    parent&.parent&.update!("#{type_in_chain}_id": nil)
  end

  # TODO: this should be in an async worker
  def create_children
    return unless type_in_chain == 'front_end_token'

    credentials = Spotify::Client.new(token).authorize
    child_token = Integration.create!(
      front_end_token_id: id,
      type_in_chain: 'active_token',
      token: credentials[:access_token],
      expires_at: Time.zone.now + credentials[:expires_in].seconds
    )
    Integration.create!(
      type_in_chain: 'refresh_token',
      token: credentials[:refresh_token],
      active_token_id: child_token.id
    )
  end
end
