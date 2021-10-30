# == Schema Information
#
# Table name: integrations
#
#  id               :bigint           not null, primary key
#  email            :string
#  expires_at       :datetime
#  metadata         :jsonb
#  name             :string
#  provider         :string           not null
#  token            :string
#  type             :string
#  uuid             :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  refresh_token_id :bigint
#
# Indexes
#
#  index_integrations_on_provider_and_token_and_uuid  (provider,token,uuid)
#  index_integrations_on_refresh_token_id             (refresh_token_id)
#
# Foreign Keys
#
#  fk_rails_...  (refresh_token_id => integrations.id)
#
require 'rails_helper'

RSpec.describe Integration, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
