# == Schema Information
#
# Table name: votations
#
#  id                  :bigint           not null, primary key
#  in_progress         :boolean          not null
#  queued              :boolean          not null
#  scheduled_end_at    :datetime         not null
#  scheduled_end_for   :datetime         not null
#  scheduled_start_at  :datetime         not null
#  scheduled_start_for :datetime         not null
#  started_at          :datetime
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  account_id          :bigint           not null
#  ongoing_playlist_id :bigint           not null
#
# Indexes
#
#  index_votations_on_account_id                          (account_id)
#  index_votations_on_account_id_and_ongoing_playlist_id  (account_id,ongoing_playlist_id)
#  index_votations_on_ongoing_playlist_id                 (ongoing_playlist_id)
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#  fk_rails_...  (ongoing_playlist_id => ongoing_playlists.id)
#
require 'rails_helper'

RSpec.describe Votation, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
