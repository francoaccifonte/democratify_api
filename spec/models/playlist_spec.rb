# == Schema Information
#
# Table name: playlists
#
#  id           :bigint           not null, primary key
#  description  :string
#  external_url :string
#  name         :string
#  provider     :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  account_id   :bigint
#  external_id  :string
#
# Indexes
#
#  index_playlists_on_account_id  (account_id)
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#
require 'rails_helper'

RSpec.describe Playlist, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
