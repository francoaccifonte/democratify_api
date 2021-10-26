# == Schema Information
#
# Table name: accounts
#
#  id           :bigint           not null, primary key
#  email        :string           not null
#  name         :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  playlists_id :bigint
#
# Indexes
#
#  index_accounts_on_email         (email) UNIQUE
#  index_accounts_on_name          (name) UNIQUE
#  index_accounts_on_playlists_id  (playlists_id)
#
# Foreign Keys
#
#  fk_rails_...  (playlists_id => playlists.id)
#
require 'rails_helper'

RSpec.describe Account, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
