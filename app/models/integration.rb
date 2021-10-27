# == Schema Information
#
# Table name: integrations
#
#  id               :bigint           not null, primary key
#  email            :string
#  integration_type :string           not null
#  metadata         :jsonb
#  name             :string
#  token            :string           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  user_id          :bigint
#
# Indexes
#
#  index_integrations_on_integration_type_and_user_id  (integration_type,user_id) UNIQUE
#  index_integrations_on_user_id                       (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Integration < ApplicationRecord
end
