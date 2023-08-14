# == Schema Information
#
# Table name: accounts
#
#  id         :bigint           not null, primary key
#  email      :string           not null
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_accounts_on_email  (email) UNIQUE
#  index_accounts_on_name   (name) UNIQUE
#
class Account < ApplicationRecord
  has_many :spotify_playlists, dependent: :destroy
  has_one :spotify_user, dependent: :destroy
  has_one :ongoing_playlist, dependent: :destroy
  has_many :votations, dependent: :destroy
  has_many :votation_candidates, dependent: :destroy
end
