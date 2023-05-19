# == Schema Information
#
# Table name: accounts
#
#  id              :bigint           not null, primary key
#  email           :string           not null
#  name            :string
#  password_digest :string
#  token           :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_accounts_on_email  (email) UNIQUE
#  index_accounts_on_name   (name) UNIQUE
#
class AccountSerializer < Panko::Serializer
  attributes :id, :email, :name, :created_at, :updated_at, :token, :spotify_user

  has_many :spotify_user, serializer: SpotifyUserSerializer
end
