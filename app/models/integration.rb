# == Schema Information
#
# Table name: integrations
#
#  id                 :bigint           not null, primary key
#  email              :string
#  expires_at         :datetime
#  metadata           :jsonb
#  name               :string
#  provider           :string           not null
#  token              :string
#  type_in_chain      :string
#  uuid               :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  account_id         :bigint
#  active_token_id    :bigint
#  front_end_token_id :bigint
#  refresh_token_id   :bigint
#  user_id            :bigint
#
# Indexes
#
#  index_integrations_on_account_id                   (account_id)
#  index_integrations_on_active_token_id              (active_token_id)
#  index_integrations_on_front_end_token_id           (front_end_token_id)
#  index_integrations_on_provider_and_token_and_uuid  (provider,token,uuid)
#  index_integrations_on_refresh_token_id             (refresh_token_id)
#  index_integrations_on_user_id                      (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#  fk_rails_...  (active_token_id => integrations.id)
#  fk_rails_...  (front_end_token_id => integrations.id)
#  fk_rails_...  (refresh_token_id => integrations.id)
#  fk_rails_...  (user_id => users.id)
#
class Integration < ApplicationRecord
  include IntegrationFilter
  include IntegrationChainSync

  # TODO: enum sobre type_in_chain

  TYPE_IN_CHAIN_TYPES = %w[active_token refresh_token front_end_token].freeze

  CHILD_DICT = {
    'front_end_token' => 'refresh_token',
    'refresh_token' => 'active_token',
  }.freeze

  PARENT_DICT = {
    'refresh_token' => 'front_end_token',
    'active_token' => 'refresh_token',
  }.freeze

  belongs_to :front_end_token, class_name: 'Integration', foreign_key: :front_end_token_id, required: false
  belongs_to :active_token, class_name: 'Integration', foreign_key: :active_token_id, dependent: :destroy,
                            required: false
  belongs_to :refresh_token, class_name: 'Integration', foreign_key: :refresh_token_id, dependent: :destroy,
                             required: false

  before_validation :set_provider, on: :create

  validates :type_in_chain, {
    presence: true,
    inclusion: { in: %w[front_end_token active_token refresh_token] }
  }

  validate :child_tokens_have_parent

  def child_tokens_have_parent
    return unless %w[active_token refresh_token].include?(type_in_chain)
    return if parent.present?

    errors.add(:base, 'Child tokens must have a parent')
    false
  end

  def active?
    active_token.present?
  end

  def parent
    send(parent_type) if parent_type.present?
  end

  def child
    send(child_type) if child_type.present?
  end

  def child_type
    CHILD_DICT[type_in_chain]
  end

  def parent_type
    PARENT_DICT[type_in_chain]
  end

  def ids
    {
      front_end_token_id: front_end_token_id,
      active_token_id: active_token_id,
      refresh_token_id: refresh_token_id,
    }
  end

  private

  def set_provider
    return if provider.present?
    return if type_in_chain == 'front_end_token'

    self.provider = parent.provider
  end
end
