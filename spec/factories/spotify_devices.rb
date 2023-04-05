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
FactoryBot.define do
  factory :spotify_device do
  end
end
