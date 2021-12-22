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
FactoryBot.define do
  factory :account do
    email { Faker::Internet.email }
    name { Faker::Name.name }
    token { Faker::Lorem.characters(number: 50) }
  end
end
