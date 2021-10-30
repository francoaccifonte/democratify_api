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
require 'rails_helper'

RSpec.describe Integration, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
