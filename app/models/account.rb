# == Schema Information
#
# Table name: accounts
#
#  id         :bigint           not null, primary key
#  email      :string           not null
#  name       :string
#  token      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_accounts_on_email  (email) UNIQUE
#  index_accounts_on_name   (name) UNIQUE
#
class Account < ApplicationRecord
  has_many :users, dependent: :destroy
  has_many :spotify_playlists, dependent: :destroy
  has_many :spotify_users, dependent: :destroy
  has_one :ongoing_playlist, dependent: :destroy
  has_many :votations, dependent: :destroy
  has_many :votation_candidates, dependent: :destroy

  before_validation :set_token

  private

  def set_token
    self.token = loop do
      random_token = SecureRandom.urlsafe_base64(nil, false)
      break random_token unless Account.exists?(token: random_token)
    end
  end
end
