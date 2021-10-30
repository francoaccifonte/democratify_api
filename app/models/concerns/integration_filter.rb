module IntegrationFilter
  extend ActiveSupport::Concern

  included do
    scope :front_end_token, -> { where(type_in_chain: 'front_end_token') }
    scope :active_token, -> { where(type_in_chain: 'active_token') }
    scope :refresh_token, -> { where(type_in_chain: 'refresh_token') }
  end
end
