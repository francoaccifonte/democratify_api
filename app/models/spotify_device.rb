# == Schema Information
#
# Table name: spotify_devices
#
#  id                 :bigint           not null, primary key
#  device_type        :string           not null
#  is_active          :boolean          default(FALSE), not null
#  is_private_session :boolean          default(FALSE)
#  is_restricted      :boolean          default(FALSE)
#  is_selected        :boolean          default(FALSE)
#  name               :string           not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  external_id        :string           not null
#  spotify_user_id    :bigint           not null
#
# Indexes
#
#  index_spotify_devices_on_spotify_user_id  (spotify_user_id)
#
# Foreign Keys
#
#  fk_rails_...  (spotify_user_id => spotify_users.id)
#
class SpotifyDevice < ApplicationRecord
  belongs_to :spotify_user

  delegate :account, to: :spotify_user

  scope :active, -> { where(is_active: true) }
end
